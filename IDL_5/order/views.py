from django.contrib.auth.mixins import LoginRequiredMixin
from django.shortcuts import render, redirect
from django.urls import reverse
from django.views import View
from django_redis import get_redis_connection
from goods.models import GoodsSKU
from user.models import Address

class OrderPlaceView(LoginRequiredMixin, View):
    def post(self, request):
        context = { }
        return render(request, 'place_order.html', context)
class OrderPlaceView(LoginRequiredMixin, View):

    def post(self, request):
        user = request.user
        sku_ids = request.POST.getlist('sku_ids')
        if not sku_ids:
            return redirect(reverse('cart:show'))
        conn = get_redis_connection('default')
        cart_key = 'cart%d' % user.id
        #         遍历
        skus = []
        total_count = 0
        total_price = 0
        for sku_id in sku_ids:
            sku = GoodsSKU.objects.get(id=sku_id)
            # 获取用户购物的商品的数量
            count = conn.hget(cart_key, sku_id)
            amount = sku.price * int(count)
            sku.count = int(count)
            sku.amount = amount
            skus.append(sku)
            total_count += int(count)
            total_price += amount
        # 运费
        transit_price = 10
        # 实付款
        total_pay = total_price + transit_price
        # 获取用户的收件地址
        addrs = Address.objects.filter(user=user)
        sku_ids = ','.join(sku_ids)
        context = {
            'skus': skus, 'total_count': total_count,
            'total_price': total_price, 'transit_price': transit_price,
            'total_pay': total_pay, 'addrs': addrs, 'sku_ids': sku_ids
        }
        return render(request, 'place_order.html', context)
from django.http import JsonResponse
from order.models import OrderInfo,OrderGoods
from datetime import datetime

class OrderCommitView(View):
    def post(self, request):
        user = request.user
        if not user.is_authenticated:
            return JsonResponse({'res': 0, 'errmsg': '用户未登录'})
        addr_id = request.POST.get('addr_id')
        pay_method = request.POST.get('pay_method')
        sku_ids = request.POST.get('sku_ids')
        if not all([addr_id, pay_method, sku_ids]):
            return JsonResponse({'res': 1, 'errmsg': '参数不完整'})
        if pay_method not in OrderInfo.PAY_METHODS.keys():
            return JsonResponse({'res': 2, 'errmsg': '非法额支付方式'})
        try:
            addr = Address.objects.get(id=addr_id)
        except Address.DoesNotExist:
            return JsonResponse({'res': 3, 'errmsg': '地址非法'})

        #         创建订单核心业务处理代码
        order_id = datetime.now().strftime('%Y%m%d%H%M%S') + str(user.id)
        transit_price = 0
        total_count = 0
        total_price = 0

        try:
            order = OrderInfo.objects.create(order_id=order_id,
                                             user=user,
                                             addr=addr,
                                             pay_method=pay_method,
                                             total_count=total_count,
                                             total_price=total_price,
                                             transit_price=transit_price)
            # 用户订单有几个商品，想订单表中加入几个商品
            conn = get_redis_connection('default')
            car_key = 'cart%d' % user.id
            sku_ids = sku_ids.split(',')
            for sku_id in sku_ids:
                sku = GoodsSKU.objects.get(id=sku_id)
                count = conn.hget(car_key, sku_id)
                if int(count) > sku.stock:
                    # transaction.savepoint_rollback(save_id)  # 回滚到数据库保存点
                    return JsonResponse({'res': 6, 'errmsg': '商品库存不足！'})

                OrderGoods.objects.create(order=order,
                                          sku=sku,
                                          count=count,
                                          price=sku.price)
                # 更新产品的库存和销量
                sku.stock -= int(count)
                sku.sales += int(count)
                sku.save()

                amount = sku.price * int(count)
                total_count += int(count)
                total_price += amount

            # 更新订单信息表的商品的总数量
            order.total_count = total_count
            order.total_price = total_price
            order.save()
        except:
            # transaction.savepoint_rollback(save_id)
            return JsonResponse({'res': 7, 'errmsg': '订单创建失败～'})
        # transaction.savepoint_commit(save_id)
        conn.hdel(car_key, *sku_ids)
        return JsonResponse({'res': 5, 'message': '创建成功～'})
class OrderPayView(View):
    def post(self, request):
        pay_url = ''
        return JsonResponse({'res': 3, 'pay_url': pay_url})


class CheckPayView(View):
    def post(self, request):
        return JsonResponse({'res': 4, 'errmsg': '支付失败'})


class CommentView(View):
    def get(self,request,order_id):
        user = request.user
        if not order_id :
            return  redirect(reverse('user:order'))
        try:
            order = OrderInfo.objects.get(order_id= order_id ,user=user)
        except OrderInfo.DoesNotExist:
            return redirect(reverse('user:order'))

        order.status_name = OrderInfo.ORDER_STATUS[order.order_status]
        order_skus = OrderGoods.objects.filter(order_id = order_id)
        for order_sku in order_skus:
            amount = order_sku.count * order_sku.price
            order_sku.amount =amount
        order.order_status = order_skus

        return  render(request,'order_comment.html',{'order':order,'order_skus':order_skus})

    def post(self,request ,order_id):
        user = request.user
        if not order_id:
            return  redirect(reverse('user:order'))
        try:
            order = OrderInfo.objects.get(order_id =order_id ,user= user)
        except OrderInfo.DoesNotExist:
            return redirect(reverse('user:order'))

        total_count = request.POST.get('total_count')
        total_count = int(total_count)
        for i in range(1,total_count +1):
            sku_id = request.POST.get('sku_%d'%i)
            content  =request.POST.get('content_%d'%i ,'')
            try:
                order_goods = OrderGoods.objects.get(order=order, sku_id =sku_id)
            except OrderGoods.DoesNotExist:
                continue

            order_goods.comment = content
            order_goods.save()

        order.order_status = 5
        order.save()

        return redirect(reverse('user:order',kwargs={'page': 1}))