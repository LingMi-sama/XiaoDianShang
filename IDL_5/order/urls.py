from django.contrib import admin
from django.urls import path ,include

from order.views import OrderPlaceView, OrderCommitView, OrderPayView, CheckPayView, CommentView

app_name ="order"
urlpatterns = [
    path('place', OrderPlaceView.as_view(), name='place'),
    path('commit', OrderCommitView.as_view(), name='commit'),
    path('pay', OrderPayView.as_view(), name='pay'),
    path('check', CheckPayView.as_view(), name='check'),
    path('comment/<order_id>', CommentView.as_view(), name='comment'),
]