from django.urls import path
from . import views

urlpatterns = [

    path('', views.home, name="home"),
    path('dashboard/<str:pk>/', views.dashboard, name="dashboard"),
    path('register/', views.registerPage, name="register"),
    path('login/', views.loginPage, name="login"),
]