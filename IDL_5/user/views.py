#from audioop import reverse #使用反向解析
import re  #导入正则

from django.contrib.auth import authenticate, login
from django.contrib.auth.mixins import LoginRequiredMixin
from django.core.paginator import Paginator
from django.shortcuts import render, redirect,reverse
from django.views import View
from django_redis import get_redis_connection

from goods.models import GoodsSKU
from order.models import OrderInfo, OrderGoods
from user.models import User, Address
from django.contrib.auth import logout


class RegisterView(View):
    def get(self, request):
        return render(request, 'register.html')

    def post(self, request):
        username = request.POST.get('user_name')
        password = request.POST.get('pwd')
        email = request.POST.get('email')
        allow = request.POST.get('allow')

        if not all([username, password, email]):
            return render(request, 'register.html', {'errmsg': '数据不完整'})
        if not re.match('\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}', email):
            return render(request, 'register.html', {'errmsg': '邮箱格式不正确'})
        if allow != 'on':
            return render(request, 'register.html', {'errmsg': '请同意协议哦!'})
        try:
            user = User.objects.get(username=username)
        except User.DoesNotExist:
            user = None
        if user:
            return render(request, 'register.html', {'errmsg': '用户名已经存在!'})
        user = User.objects.create_user(username, email, password)
        user.is_active = 0
        user.save()
        return redirect(reverse('goods:index'))


class LoginView(View):
    def get(self, request):
        if 'username' in request.COOKIES:
            username = request.COOKIES.get('username')
            checked = 'checked'
        else:
            username = ''
            checked = ''
        return render(request, 'login.html', {'username': username, 'checked': checked})

    def post(self, request):
        username = request.POST.get('username')
        password = request.POST.get('pwd')
        if not all([username, password]):
            return render(request, 'login.html', {'errmsg': '数据不完整'})

        user = authenticate(username=username, password=password)
        if user is not None:
            login(request, user)
            next_url = request.GET.get('next', reverse('goods:index'))
            reponse = redirect(next_url)
            remember = request.POST.get('remember')
            # 判断是后记住用户名
            if remember == 'on':
                reponse.set_cookie('username', username, max_age=7 * 24 * 3600)
            else:
                reponse.delete_cookie('username')
            return reponse

        else:
            return render(request, 'login.html', {'errmsg': '用户名或密码错误'})


class UserInfoView(LoginRequiredMixin, View):
    def get(self, request):
        user = request.user
        address = Address.objects.get_default_address(user)
        #  获取历史浏览记录
        con = get_redis_connection('default')
        history_key = 'history_%d' % user.id
        sku_ids = con.lrange(history_key, 0, 4)

        goods_li = [GoodsSKU.objects.get(id=_id) for _id in sku_ids]

        context = {'page': 'user', 'address': address, 'goods_li': goods_li}
        return render(request, 'user_center_info.html', context)

from django.views.generic import ListView  #导入包
class UserOrderView(LoginRequiredMixin, ListView):
    def get(self, request, page):
        user = request.user
        orders = OrderInfo.objects.filter(user=user).order_by('-create_time')
        for order in orders:
            order_skus = OrderGoods.objects.filter(order_id=order.order_id)
            for order_sku in order_skus:
                amount = order_sku.count * order_sku.price
                order_sku.amount = amount
            order.status_name = OrderInfo.ORDER_STATUS[order.order_status]
            order.order_skus = order_skus
        #
        paginator = Paginator(orders, 3)
        try:
            page = int(page)
        except Exception as e:
            page = 1

        if page > paginator.num_pages:
            page = 1

        order_page = paginator.page(page)
        # 控制只显示5页
        num_pages = paginator.num_pages
        if num_pages < 5:
            pages = range(1, num_pages + 1)
        elif page <= 3:
            pages = range(1, 5)
        elif num_pages - page <= 2:
            pages = range(num_pages - 4, num_pages + 1)
        else:
            pages = range(page - 2, page + 3)

        context = {'order_page': order_page,
               'pages': pages,
               'page': orders}
        return render(request, 'user_center_order.html', context)


class AddressView(LoginRequiredMixin, View):
    def get(self, request):
        user = request.user

        address = Address.objects.get_default_address(user)
        return render(request, 'user_center_site.html', {'page': 'address', 'address': address})

    def post(self, request):
        receiver = request.POST.get('receiver')
        addr = request.POST.get('addr')
        zip_code = request.POST.get('zip_code')
        phone = request.POST.get('phone')

        if not all([receiver, addr, phone]):
            return render(request, 'user_center_site.html', {'errmsg': '数据不完整'})
        if not re.match('^1[3|4|5|7|8][0-9]{9}', phone):
            return render(request, 'user_center_site.html', {'errmsg': '电话号码不正确'})
        user = request.user
        address = Address.objects.get_default_address(user=user)
        is_default = False if address else True
        Address.objects.create(user=user, receiver=receiver, addr=addr, phone=phone, is_default=is_default)
        return redirect(reverse('user:address'))
class LogoutView(View):
    def get(self, request):
        logout(request)
        return redirect(reverse('goods:index'))