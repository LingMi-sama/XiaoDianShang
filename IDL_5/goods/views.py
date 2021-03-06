from django.core.paginator import Paginator
from django.shortcuts import render, redirect
from django.views import View
from django_redis import get_redis_connection
from django.urls import reverse
from goods.models import GoodsType, IndexGoodsBanner, IndexPromotionBanner, IndexTypeGoodsBanner, GoodsSKU
from order.models import OrderGoods


class IndexView(View):
    def get(self, request):
        types = GoodsType.objects.all()
        goods_banners = IndexGoodsBanner.objects.all().order_by('index')
        promotion_banners = IndexPromotionBanner.objects.all().order_by('index')
        for type in types:
            image_banners = IndexTypeGoodsBanner.objects.filter(type=type, display_type=1).order_by('index')
            title_banners = IndexTypeGoodsBanner.objects.filter(type=type, display_type=0).order_by('index')
            type.image_banners = image_banners
            type.title_banners = title_banners
        context = {
            'types': types,
            'goods_banners': goods_banners, 'promotion_banners': promotion_banners}
        cart_count = 0
        return render(request, 'index.html', context)
class DetailView(View):
    def get(self, request, goods_id):
        try:
            sku = GoodsSKU.objects.get(id=goods_id)
        except GoodsSKU.DoesNotExist:
            return redirect(reverse('goods:index'))
        types = GoodsType.objects.all()
        sku_orders = OrderGoods.objects.filter(sku=sku).exclude(comment='')
        new_skus = GoodsSKU.objects.filter(type=sku.type).order_by('-create_time')[:2]
        # 获取同一个SKU的其他规格商品
        same_spu_skus = GoodsSKU.objects.filter(goods=sku.goods).exclude(id=goods_id)
        user = request.user
        cart_count = 0
        if user.is_authenticated:
            conn = get_redis_connection('default')
            cart_key = 'cart_%d' % user.id
            cart_count = conn.hlen(cart_key)
            # 添加历史记录
            conn = get_redis_connection('default')
            history_key = 'history_%d' % user.id
            conn.lrem(history_key, 0, goods_id)
            conn.lpush(history_key, goods_id)
            conn.ltrim(history_key, 0, 4)
        context = {
            'sku': sku, 'types': types, 'sku_orders': sku_orders, 'new_skus': new_skus,
            'same_spu_skus': same_spu_skus,
            'cart_count': cart_count
        }

        return render(request, 'detail.html', context)
class ListsView(View):
    def get(self, request, type_id, page):
        # 先获取种类是否存在
        try:
            type = GoodsType.objects.get(id=type_id)
        except GoodsType.DoesNotExist:
            return redirect(reverse('goods:index'))
        types = GoodsType.objects.all()
        sort = request.GET.get('sort')
        if sort == 'price':
            skus = GoodsSKU.objects.filter(type=type).order_by('price')
        elif sort == 'hot':
            skus = GoodsSKU.objects.filter(type=type).order_by('-sales')
        else:
            sort = 'default'
            skus = GoodsSKU.objects.filter(type=type).order_by('-id')
        new_skus = GoodsSKU.objects.filter(type=type).order_by('-create_time')[:2]
        # 对数据进行分页  只显示 5个页码
        paginator = Paginator(skus, 1)
        try:
            page = int(page)
        except Exception as e:
            page = 1

        if page > paginator.num_pages:
            page = 1

        skus_page = paginator.page(page)

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

        new_skus = GoodsSKU.objects.filter(type=type).order_by('-create_time')[:2]

        user = request.user
        cart_count = 0
        if user.is_authenticated:
            conn = get_redis_connection('default')
            cart_key = 'cart%d' % user.id
            cart_count = conn.hlen(cart_key)

        context = {
            'type': type, 'types': types,
            'skus_page': skus_page, 'new_skus': new_skus,
            'cart_count': cart_count, 'sort': sort, 'pages': pages,
        }
        return render(request, 'list.html', context)
