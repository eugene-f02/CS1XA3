from django.http import HttpResponse, HttpResponseNotFound, JsonResponse
from django.shortcuts import render,redirect,get_object_or_404
from django.contrib.auth.forms import AuthenticationForm, UserCreationForm, PasswordChangeForm
from django.contrib.auth import authenticate, login, logout, update_session_auth_hash
from django.contrib import messages
import re
import datetime

from . import models
from django.core.exceptions import ValidationError


def messages_view(request):
    """Private Page Only an Authorized User Can View, renders messages page
       Displays all posts and friends, also allows user to make new posts and like posts
    Parameters
    ---------
      request: (HttpRequest) - should contain an authorized user
    Returns
    --------
      out: (HttpResponse) - if user is authenticated, will render private.djhtml
    """

    if request.user.is_authenticated:
        user_info = models.UserInfo.objects.get(user=request.user)
        friends = list(user_info.friends.all())

        # TODO Objective 9: query for posts (HINT only return posts needed to be displayed)
        posts = list(models.Post.objects.order_by('id'))
        posts = posts[::-1]
        if 'posts' not in request.session:
            request.session['posts']=1

        # TODO Objective 10: check if user has like post, attach as a new attribute to each post
        likes=[]
        for post in models.Post.objects.order_by('id'):
            likes.append(len(post.likes.all()))
        likes=likes[::-1]

        context = { 'user_info' : user_info,
                    'friends' : friends,
                    'sessionPosts': request.session['posts'],
                    'postsAndLikes' : list(zip(posts,likes)) }
        return render(request,'messages.djhtml',context)

    request.session['failed'] = True
    return redirect('login:login_view')

def account_view(request):
    """Private Page Only an Authorized User Can View, allows user to update
       their account information (i.e UserInfo fields), including changing
       their password
    Parameters
    ---------
      request: (HttpRequest) should be either a GET or POST
    Returns
    --------
      out: (HttpResponse)
                 GET - if user is authenticated, will render account.djhtml
                 POST - handle form submissions for changing password, or User Info
                        (if handled in this view)
    """
    if request.user.is_authenticated:

        special_chars = "!\"#$%&'()*+,-./:;<=>?@[\]^_`{|}~"

        def data_isValid(authenticated,currentPassowrd,pswrd,confPswrd):
            context={
            'valid':True,
            "currentPassNotMatch":False,
            'acceptableLength': False,
            'specialChar':False,
            'lowerChar':False,
            'upperChar':False,
            'numericChar':False,
            'NotIdentical':False,
            'confirmationSuccess':False,
            }

            if authenticated==False:
                context["currentPassNotMatch"]=True
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

                if pswrd!=currentPassowrd:
                    context['NotIdentical']=True

                if confPswrd == pswrd:
                    context['confirmationSuccess']=True

                

                context["currentPassNotMatch"]=True
                if False in context.values():
                    context['valid']=False
                context["currentPassNotMatch"]=False
                return context


        user_info = models.UserInfo.objects.get(user=request.user)
        context = { 'user_info' : user_info,
                }

        # TODO Objective 3: Create Forms and Handle POST to Update UserInfo / Password
        if request.method == "POST":
            if request.POST['type'] == 'newPass':
                uname = request.user.username
                authenticated = True
                currentPassword = request.POST['currentPassword']
                newPassword = request.POST['newPassword']
                confNewPassword=request.POST['confNewPassword']


                if authenticate(request, username=uname, password=currentPassword)==None:
                    authenticated=False
                data=data_isValid(authenticated,currentPassword,newPassword,confNewPassword)
                if request.POST['fromButton']=="False":
                    return JsonResponse(data)
                elif request.POST['fromButton']=="True":
                    u=request.user
                    u.set_password(newPassword)
                    u.save()
                    update_session_auth_hash(request, u)


            elif request.POST['type'] == 'info':
                employment=request.POST['employment'].strip()
                location=request.POST['location'].strip()
                birthday=request.POST['birthday'].strip()

                if request.POST['fromButton']=="False":
                    newInterest=request.POST['newInterest'].strip()
                    data={'taken':"False",
                        "BD_Format":"Null"}
                    if newInterest!='':
                        for inter in user_info.interests.all():
                            if inter.label == newInterest:
                                data['taken']="True"
                                break
                    else:
                        data['taken']="Empty"
                    if len(birthday)!=0:
                        x=re.search("^[0-9]{4}-[0-9]{2}-[0-9]{2}$",birthday)
                        if not x:
                            data["BD_Format"]="Fail"
                    return JsonResponse(data)
                elif request.POST['fromButton']=="True":

                    if employment=="" and location=='' and birthday=='' :
                        return JsonResponse({"allEmpty":True})

                    if employment!='':
                        user_info.employment=employment
                    if location!='':
                        user_info.location=location
                    if birthday!='':
                        user_info.birthday=birthday
    

                    data={  
                        'employment' :employment,
                        'location': location,
                        "BD_Format":"OK",
                    }

                    try:
                        user_info.save()
                        if len(birthday)!=0:
                            dt = datetime.datetime.strptime(birthday, '%Y-%m-%d') 
                            date=dt.strftime("%b. %d, %Y")
                            if date.count(". 0")>0:
                                date=date.replace(". 0", ". ")
                            data['birthday']=date

                    except ValidationError:
                        return JsonResponse({"BD_Format":"Fail"})
                    
                    return JsonResponse(data)

            elif request.POST['type'] == 'interest':
                newInterest = request.POST['newInterest'].strip()
                i=models.Interest(newInterest)
                i.save()
                user_info.interests.add(i)
                return JsonResponse({'new':newInterest})
            elif request.POST['type'] == 'removeBut':
                interest =request.POST['id']
                user_info.interests.remove(interest)

                isOnlyInterest=True
                for person in models.UserInfo.objects.all():
                    if models.Interest.objects.get(label=interest) in person.interests.all():
                        isOnlyInterest=False
                        break
                if isOnlyInterest:
                    models.Interest.objects.get(label=interest).delete()
                return JsonResponse({'id':interest})

        return render(request,'account.djhtml',context)

    request.session['failed'] = True
    return redirect('login:login_view')

def people_view(request):
    """Private Page Only an Authorized User Can View, renders people page
       Displays all users who are not friends of the current user and friend requests
    Parameters
    ---------
      request: (HttpRequest) - should contain an authorized user
    Returns
    --------
      out: (HttpResponse) - if user is authenticated, will render people.djhtml
    """
    # global max_new_ppl
    if request.user.is_authenticated:
        user_info = models.UserInfo.objects.get(user=request.user)
        # TODO Objective 4: create a list of all users who aren't friends to the current user (and limit size)
        all_people = models.UserInfo.objects.all().exclude(user=user_info)
        for aUser in user_info.friends.all():
            all_people=all_people.exclude(user=aUser)
        all_people=list(all_people)
        # max_new_ppl=len(all_people)

        if 'people' not in request.session:
            request.session['people']=1

        # TODO Objective 5: create a list of all friend requests to current user
        friend_requests = []
        for req in models.FriendRequest.objects.all():
            if req.to_user==user_info:
                friend_requests.append(req.from_user)


        context = { 'user_info' : user_info,
                    'sessionDisplayPeople' :request.session['people'],
                    'all_people' : all_people,
                    'friend_requests' : friend_requests }
                    
        return render(request,'people.djhtml',context)

    request.session['failed'] = True
    return redirect('login:login_view')

def like_view(request):
    '''Handles POST Request recieved from clicking Like button in messages.djhtml,
       sent by messages.js, by updating the corrresponding entry in the Post Model
       by adding user to its likes field
    Parameters
	----------
	  request : (HttpRequest) - should contain json data with attribute postID,
                                a string of format post-n where n is an id in the
                                Post model

	Returns
	-------
   	  out : (HttpResponse) - queries the Post model for the corresponding postID, and
                             adds the current user to the likes attribute, then returns
                             an empty HttpResponse, 404 if any error occurs
    '''
    postIDReq = request.POST.get('postID')
    if postIDReq is not None:
        # remove 'post-' from postID and convert to int
        # TODO Objective 10: parse post id from postIDReq
        postID = int(postIDReq)

        if request.user.is_authenticated:
            user_info=models.UserInfo.objects.get(user=request.user)
            # TODO Objective 10: update Post model entry to add user to likes field
            post=models.Post.objects.get(id=postID)
            totalLikes=len(post.likes.all())
            data={'totalLikes':totalLikes,
                    'success':False,
                    'butId':postIDReq}

            if post.likes.all().filter(user=user_info).exists()==False:
                post.likes.add(user_info)
                data['totalLikes']+=1
                data['success']=True

            return JsonResponse(data)


            # # return status='success'
            # return HttpResponse()
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('like_view called without postID in POST')

def post_submit_view(request):
    '''Handles POST Request recieved from submitting a post in messages.djhtml by adding an entry
       to the Post Model
    Parameters
	----------
	  request : (HttpRequest) - should contain json data with attribute postContent, a string of content

	Returns
	-------
   	  out : (HttpResponse) - after adding a new entry to the POST model, returns an empty HttpResponse,
                             or 404 if any error occurs
    '''
    postContent = request.POST.get('postContent')
    if postContent is not "" and postContent is not None:
        if request.user.is_authenticated:
            owner=models.UserInfo.objects.get(user=request.user)
            models.Post.objects.create(owner=owner,content=postContent)
            # # TODO Objective 8: Add a new entry to the Post model
            return HttpResponse()
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('post_submit_view called without postContent in POST')

def more_post_view(request):
    '''Handles POST Request requesting to increase the amount of Post's displayed in messages.djhtml
    Parameters
	----------
	  request : (HttpRequest) - should be an empty POST

	Returns
	-------
   	  out : (HttpResponse) - should return an empty HttpResponse after updating hte num_posts sessions variable
    '''
    # global
    if request.user.is_authenticated:
        # update the # of posts dispalyed
        max_posts=len(models.Post.objects.all())
        # TODO Objective 9: update how many posts are displayed/returned by messages_view
        data={"success":False}
        if request.is_ajax() and request.session['posts']<max_posts:
            request.session['posts']+=1
            data['success']=True
        # return status='success'
        return JsonResponse(data)


    return redirect('login:login_view')

def more_ppl_view(request):
    '''Handles POST Request requesting to increase the amount of People displayed in people.djhtml
    Parameters
	----------
	  request : (HttpRequest) - should be an empty POST

	Returns
	-------
   	  out : (HttpResponse) - should return an empty HttpResponse after updating the num ppl sessions variable
    '''
    # global max_new_ppl
    if request.user.is_authenticated:
        # update the # of people dispalyed
        # TODO Objective 4: increment session variable for keeping track of num ppl displayed
        all_people = models.UserInfo.objects.all().exclude(user=request.user)
        for aUser in models.UserInfo.objects.get(user=request.user).friends.all():
            all_people=all_people.exclude(user=aUser)
        max_new_ppl=len(all_people)

        data={"success":False}
        if request.is_ajax() and request.session['people']<max_new_ppl:
            request.session['people']+=1
            data['success']=True
        # return status='success'
        return JsonResponse(data)

    return redirect('login:login_view')

def friend_request_view(request):
    '''Handles POST Request recieved from clicking Friend Request button in people.djhtml,
       sent by people.js, by adding an entry to the FriendRequest Model
    Parameters
	----------
	  request : (HttpRequest) - should contain json data with attribute frID,
                                a string of format fr-name where name is a valid username

	Returns
	-------
   	  out : (HttpResponse) - adds an etnry to the FriendRequest Model, then returns
                             an empty HttpResponse, 404 if POST data doesn't contain frID
    '''
    frID = request.POST.get('frID')
    if frID is not None:
        # remove 'fr-' from frID
        username = frID[3:]

        if request.user.is_authenticated:
            # TODO Objective 5: add new entry to FriendRequest
            u=models.User.objects.get(username=username)
            toUser=models.UserInfo.objects.get(user=u)
            currentU=request.user
            fromUser=models.UserInfo.objects.get(user=currentU)
            if models.FriendRequest.objects.filter(to_user=toUser,from_user=fromUser).exists():
                return JsonResponse({"id": username,'success':False})
            friendReq=models.FriendRequest.objects.create(to_user=toUser,from_user=fromUser)
            friendReq.save()



            # return status='success'
            return JsonResponse({"id": username,'success':True})
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('friend_request_view called without frID in POST')

def accept_decline_view(request):
    '''Handles POST Request recieved from accepting or declining a friend request in people.djhtml,
       sent by people.js, deletes corresponding FriendRequest entry and adds to users friends relation
       if accepted
    Parameters
	----------
	  request : (HttpRequest) - should contain json data with attribute decision,
                                a string of format A-name or D-name where name is
                                a valid username (the user who sent the request)

	Returns
	-------
   	  out : (HttpResponse) - deletes entry to FriendRequest table, appends friends in UserInfo Models,
                             then returns an empty HttpResponse, 404 if POST data doesn't contain decision
    '''
    data = request.POST.get('decision')
    if data is not None:
        # TODO Objective 6: parse decision from data

        if request.user.is_authenticated:
            uFrom=request.POST.get('id')
            u1=models.User.objects.get(username=uFrom)
            user_info_From=models.UserInfo.objects.get(user=u1)
            uCurrent=request.user
            user_info_Current=models.UserInfo.objects.get(user=uCurrent)
            models.FriendRequest.objects.filter(to_user=user_info_Current).filter(from_user=user_info_From).delete()
            if data=="A":
                user_info_Current.friends.add(user_info_From)
                user_info_From.friends.add(user_info_Current)
                if len(models.FriendRequest.objects.filter(to_user=user_info_From).filter(from_user=user_info_Current))==1:
                    models.FriendRequest.objects.filter(to_user=user_info_From).filter(from_user=user_info_Current).delete()



                

            # TODO Objective 6: delete FriendRequest entry and update friends in both Users
            
            # return status='success'
            return HttpResponse()
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('accept-decline-view called without decision in POST')
