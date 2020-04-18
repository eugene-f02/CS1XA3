from django.http import HttpResponse,HttpResponseNotFound, JsonResponse
from django.shortcuts import render,redirect
from django.contrib.auth.forms import AuthenticationForm, UserCreationForm, PasswordChangeForm
from django.contrib.auth import authenticate, login, logout, update_session_auth_hash
from django.contrib import messages

from social import models

special_chars = "!\"#$%&'()*+,-./:;<=>?@[\]^_`{|}~"

def login_view(request):
    """Serves lagin.djhtml from /e/macid/ (url name: login_view)
    Parameters
    ----------
      request: (HttpRequest) - POST with username and password or an empty GET
    Returns
    -------
      out: (HttpResponse)
                   POST - authenticate, login and redirect user to social app
                   GET - render login.djhtml with an authentication form
    """
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request,user)
            request.session['failed'] = False
            return redirect('social:messages_view')
        else:
            request.session['failed'] = True

    form = AuthenticationForm(request.POST)
    failed = request.session.get('failed',False)
    context = { 'login_form' : form,
                'failed' : failed }

    return render(request,'login.djhtml',context)

def logout_view(request):
    """Redirects to login_view from /e/macid/logout/ (url name: logout_view)
    Parameters
    ----------
      request: (HttpRequest) - expected to be an empty get request
    Returns
    -------
      out: (HttpResponse) - perform User logout and redirects to login_view
    """
    # TODO Objective 4 and 9: reset sessions variables

    # logout user
    logout(request)

    return redirect('login:login_view')

def signup_view(request):
    """Serves signup.djhtml from /e/macid/signup (url name: signup_view)
    Parameters
    ----------
      request : (HttpRequest) - expected to be an empty get request
    Returns
    -------
      out : (HttpRepsonse) - renders signup.djhtml
    """

    # TODO Objective 1: implement signup view
    if request.method == 'POST':
      uname = request.POST['username']
      pswrd = request.POST['password']
      confPswrd = request.POST['confPass']
      data= data_isValid(uname,pswrd,confPswrd)
      if request.is_ajax():
        return JsonResponse(data)
      else:
        models.UserInfo.objects.create_user_info(username=uname,password=pswrd)
        user = authenticate(request,username=uname, password=pswrd)
        if user is not None:
            login(request,user)
            request.session['failed'] = False
            return redirect('social:messages_view')
        else:
            request.session['failed'] = True


        
    else:
      return render(request,'signup.djhtml')

def wildcard_view(request):
  return redirect('login:login_view')

def data_isValid(uname,pswrd,confPswrd):
  context={
  'valid':True,
  "userExists":False,
  'acceptableLength': False,
  'specialChar':False,
  'lowerChar':False,
  'upperChar':False,
  'numericChar':False,
  'confirmationSuccess':False,
  }

  if models.User.objects.filter(username=uname).exists():
    context["userExists"]=True
    context['valid']=False
    return context
  else:


    if len(pswrd)>=8:
      context['acceptableLength']=True

    for char in special_chars:
      if char in pswrd:
          context['specialChar']=True
          break

    for char in pswrd:
      if char.islower():
        context['lowerChar']=True
      if char.isupper():
        context['upperChar']=True
      if char.isdigit():
        context['numericChar']=True


    if confPswrd == pswrd:
      context['confirmationSuccess']=True

    context["userExists"]=True
    if False in context.values():
      context['valid']=False
    context["userExists"]=False
    return context
   

