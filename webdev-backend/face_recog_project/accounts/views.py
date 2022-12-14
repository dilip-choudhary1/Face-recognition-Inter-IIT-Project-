from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.forms import inlineformset_factory
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.decorators import login_required

from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import Group

from .models import *
from .forms import CreateUserForm , CustomerForm
# from .decorators import allowed_users
# from .filters import OrderFilter      

def registerPage(request):
    form = CreateUserForm()

    if request.method == 'POST':
        print('posted')
        # print('Printing Post: ', request.POST)
        form = CreateUserForm(request.POST)
        if form.is_valid():
            user=form.save()
            Student.objects.create(
                user=user,
            )
            print('user created')
            return redirect('login')
        else:
            print('form not valid')

    context = {'form':form}
    return render(request, 'register.html', context)

def loginPage(request):

    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')

        user = authenticate(request, username=username, password=password)

        if user is not None:
            login(request, user)
            print( user.username)
            print( user.email)

            # names = Student.objects.all()
            
            # for i in names:
            #     if user.username == i.name:
            #         return redirect('home')

            # Student.objects.create(name=user.username , phone='', email=user.email )
            return redirect('home')

    context = {}
    return render(request, 'login.html', context)

def logoutUser(request):
    logout(request)
    return redirect('login')

@login_required(login_url='login')
def accountSettings(request):
    student = request.user.student
    form = CustomerForm(instance=student)

    if request.method == 'POST':
        form = CustomerForm(request.POST, request.FILES, instance=student)
        if form.is_valid():
            form.save()
            
    context = {'form':form}
    return render(request, 'account_settings.html', context)

@login_required(login_url='login')
def dashboard(request, pk):
    current_student = Student.objects.get(id=pk)
    students = Student.objects.all()

    context = { 'students':students, 'current_student':current_student }

    return render(request, 'dashboard.html' , context)

@login_required(login_url='login')
# @allowed_users(allowed_roles='Student')
def home(request):
    return render(request, 'home.html')

# Create your views here.
