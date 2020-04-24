# CS 1XA3 Project03 - fedorivy
## Usage
1. Clone this project to your machine
1. Have Anaconda installed
1. Create django virtual environment if it does not already exist by **cd**-ing into CS1XA3/Project03 and running
      ```
      conda env create -f djangoenv.yml
      ```   
1. Activate the environment
      ```
      conda activate djangoenv
      ```      
1.
      - Run locally:
          1. Open CS1XA3/Project03/Project03/**settings.py**
          1. Replace the path of **STATIC_ROOT** at the bottom of CS1XA3/Project03/Project03/**settings.py** to a path of a preferable directory on your machine that will store all of the static files of this project
          1. **cd** into CS1XA3/Project03 
          1. Run `python manage.py collectstatic` in order to copy over static files to the **STATIC_ROOT** directory
          1. Run `python manage.py runserver localhost:8000`
          1. You can now access *localhost:8000/e/fedorivy/* and all associated links
      - Run on mac1xa3.ca:
          1. Replace all URLS WITH macid TO YOUR ACTUAL MACID
          1. Replace macid at the bottom of CS1XA3/Project03/Project03/**settings.py** for dealing with static files 
          1. Make sure the directory $HOME/public_html/static/ exists (on the server)
          1. **cd** into CS1XA3/Project03
          1. Run `python manage.py collectstatic` in order to copy over static files to the **STATIC_ROOT** directory
          1. Run `python manage.py runserver localhost:portnum`, where **portnum** is your port number listed on mac1xa3.ca (**portnum** associated with my macid **fedorivy** is **10028**)
          1. You can now access *mac1xa3.ca/e/**macid**/* and all associated links, where **macid** is your actual macid

1. Log in with username **Eugene**, and password **12345qQ1!**  

*Note:* Database is populated with other users that have the following usernames and password:
* username: **Harry** , password: **12345qQ1!**
* username: **Andrey** , password: **12345qQ1!**
* username: **Frank**, password: **12345qQ1!**
* username: **Mary** , password: **12345qQ1!**
* username: **Gordie** , password: **12345qQ1!**
* username: **Ricky** , password: **12345qQ1!**
* username: **Sabrina** , password: **12345qQ1!**
* username: **Ashley** , password: **12345qQ1!**
* username: **Mike** , password: **12345qQ1!**

## Objective 01 (Login and SignUp Pages)
Description:
- This feature is displayed in **signup.djhtml** which is rendered by **signup_view** in *Project03/login/views.py*
- A custom form for creating a new user is designed and displayed in *Project03/login/templates/**signup.djhtml***
- The custom form makes use of JQuery and AJAX in order to display notifications of any type of improper input to the user(i.e "Password has to be at least 8 characters long", etc.). Any time changes are made to the form, a Post Request is sent from **signup.js** to */e/**macid**/signup/*, which is handled by **signup_view** (This decides whether the current state of the form is acceptable for submission)
- Submitting the form sends a POST Request to */e/**macid**/signup/*, which is handled by **signup_view** (This creates a new UserInfo, automatically logs the user in, and redirects to the messages page)

Exceptions:
- Trying to access */e/**macid**/**PATH*** (where **PATH** is anything but **logout/** or **signup/**) link will result in redirection to /e/**macid**/

## Objective 02 (Adding User Profile and Interests)
Description:
- This feature is displayed in **social_base.djhtml** which is used as a template for **messages.djhtml**, **people.djhtml**,
and **account.djhtml**, rendered by **messages_view**, **people_view** and **account_view** respectively in *Project03/social/views.py*
- This feature displays a real Profile information(i.e username, interests, employment, birthday, etc.) corresponding to the currently logged in user by using Django Template Variables

Exceptions:
- Trying to access */e/**macid**/social/messages/* link without being logged in will result in redirection to /e/**macid**/
- Trying to access */e/**macid**/social/people/* link without being logged in will result in redirection to /e/**macid**/
- Trying to access */e/**macid**/social/account/* link without being logged in will result in redirection to /e/**macid**/
- Trying to access */e/**macid**/social/**PATH*** (where **PATH** is literally anything) link without being logged in will result in redirection to /e/**macid**/

## Objective 03 (Account Settings Page)
Description:
- This feature is displayed in **account.djhtml** which is rendered by **account_view** in *Project03/social/views.py*
- A custom form for changing the user's current password is designed and displayed in *Project03/social/templates/**account.djhtml***
- A custom form for for updating user info is designed and displayed in *Project03/social/templates/**account.djhtml***
- The custom forms make use of JQuery and AJAX in order to display notifications of any type of improper input, or successful changes to the user(i.e "Password has to be at least 8 characters long", "Interest already exists", "Successfully updated", etc.). Any time changes are made to any of the forms, a Post Request is sent from **settingsPage.js** to */e/**macid**/social/account/*, which is handled by **account_view** (This decides whether the current state of each of the forms is acceptable for submission)
- Submitting any of the form sends an AJAX POST Request to */e/**macid**/social/account/*, which is handled by **account_view**  (This updates the UserInfo object accordingly). The callback function updates the content of the current page without needing to refresh it.

## Objective 04 (Displaying People List)
Description:
- This feature is displayed in **people.djhtml** which is rendered by **people_view** in *Project03/social/views.py*
- This feature displays actual Users in the middle column who are not friends of the current user
- Originally, only one user is displayed; however, when **"More"** button is clicked, an AJAX POST request is sent from **people.js** to */e/**macid**/social/moreppl/*, which is handled by **more_ppl_view**. This feature makes use of a session variable to keep track of how many people to display.  
*Note:* Logging out and back in will reset the number of Users displayed back to one.

Exceptions:
- When the number of people to display reaches its maximum, clicking the button will result in disabling the button and no other actions will be performed.
- Trying to access */e/**macid**/social/moreppl/* link without being logged in will result in redirection to /e/**macid**/
- Trying to access */e/**macid**/social/moreppl/* link with GET request will result in redirection to /e/**macid**/social/people/

## Objective 05 (Sending Friend Requests)
Description:
- This feature is displayed in **people.djhtml** which is rendered by **people_view** in *Project03/social/views.py*
- This feature allows Users to send friend requests to each other and see current pending friend requests from other Users.
- When a **"Friend Request"** button is clicked, an AJAX POST request is sent from **people.js** to */e/**macid**/social/friendrequest/*, which is handled by **friend_request_view** (This creates a new instance of **FriendRequest** and saves it to database). The callback function notifies the user whether the request has been successful or not by displaying a message next to the **"Friend Request"** button.

Exceptions:
- No multiple friend requests can be sent.
- If you send a friend request to a person who has already sent a friend request to you, and then you accept their friend request, your friend request to that user will be removed from the database. 
- Trying to access */e/**macid**/social/friendrequest/* link without being logged in will result in redirection to /e/**macid**/
- Trying to access */e/**macid**/social/friendrequest/* link with GET request will result in redirection to /e/**macid**/social/people/
- If **friend_request_view** is called without **frID** in POST, HttpResponseNotFound is returned

## Objective 06 (Accepting / Declining Friend Requests)
Description:
- This feature is displayed in **people.djhtml** which is rendered by **people_view** in *Project03/social/views.py*
- This feature allows Users to accept/decline friend requests that have been sent to them.
- When a **"Decline"**/**"Accept"** button is clicked, an AJAX POST request is sent from **people.js** to */e/**macid**/social/acceptdecline/*, which is handled by **accept_decline_view** (This deletes the corresponding FriendRequest entry. If the request was accepted, updates BOTH USERS friends relation in
the UserInfo table, otherwise, nothing else beside deleting the FriendRequest entry is performed)

Exceptions:
- Trying to access */e/**macid**/social/acceptdecline/* link without being logged in will result in redirection to /e/**macid**/
- Trying to access */e/**macid**/social/acceptdecline/* link with GET request will result in redirection to /e/**macid**/social/people/
- If **accept_decline_view** is called without **decision** in POST, HttpResponseNotFound is returned

## Objective 07 (Displaying Friends)
Description:
- This feature is displayed in **messages.djhtml** which is rendered by **messages_view** in *Project03/social/views.py*
- This feature displays all of the friends of the current user in **messages.djhtml** by using Django Template variables and for loop block.

## Objective 08 (Submitting Posts)
Description:
- This feature is displayed in **messages.djhtml** which is rendered by **messages_view** in *Project03/social/views.py*
- This feature allows user to submit their posts to the news feed
- When **"Submit"** button is clicked, an AJAX POST request is sent from **messages.js** to */e/**macid**/social/postsubmit/*, which is handled by **post_submit_view** (This adds a new entry to the Post model with the content of **post-text** field. The page is reloaded afterwards)

Exceptions:
- If the user tries to submit an empty post(i.e **post-text** field is empty), a new Post model entry will not be created, and, instead, an HttpResponseNotFound will be returned
- Trying to access */e/**macid**/social/postsubmit/* link without being logged in will result in redirection to /e/**macid**/
- Trying to access */e/**macid**/social/postsubmit/* link with GET request will result in redirection to /e/**macid**/social/messages/
- If **post_submit_view** is called without **postContent** in POST, HttpResponseNotFound is returned

## Objective 09 (Displaying Post List)
Description:
- This feature is displayed in **messages.djhtml** which is rendered by **messages_view** in *Project03/social/views.py*
- This feature displays all of the posts of all users from newest to oldest.
- Originally, only one post is displayed; however, when **"More"** button is clicked, an AJAX POST request is sent from **messages.js** to */e/**macid**/social/morepost/*, which is handled by **more_post_view**. This feature makes use of a session variable to keep track of how many posts to display.  
*Note:* Logging out and back in will reset the number of Posts displayed back to one.

Exceptions:
- When the number of posts to display reaches its maximum, clicking the button will result in disabling the button and no other actions will be performed.
- Trying to access */e/**macid**/social/morepost/* link without being logged in will result in redirection to /e/**macid**/
- Trying to access */e/**macid**/social/morepost/* link with GET request will result in redirection to /e/**macid**/social/messages/

## Objective 10 (Liking Posts (and Displaying Like Count))
Description:
- This feature is displayed in **messages.djhtml** which is rendered by **messages_view** in *Project03/social/views.py*
- This feature allows Users to like posts that are displayed in the news feed and keep track of the number of likes each of the posts has collected.
- When **"Like"** button is clicked, an AJAX POST request is sent from **messages.js** to */e/**macid**/social/like/*, which is handled by **like_view**. (This checks whether the current user has already liked that post. If the post has not been liked before, the counter of likes for this post increments by one. In either case, a notifying message will be displayed next to the button, and the button gets disabled)

Exceptions:
- Trying to access */e/**macid**/social/like/* link without being logged in will result in redirection to /e/**macid**/
- Trying to access */e/**macid**/social/like/* link with GET request will result in redirection to /e/**macid**/social/messages/
- If **like_view** is called without **postID** in POST, HttpResponseNotFound is returned

## Objective 11 (Test Database)
Description:
- The database is populated with **10** users, and you can find their usernames and passwords in the ***Usage*** section of this README file
- In order to showcase all the functionality I’ve implemented, I:       
            - Created multiple posts and liked them from several different User accounts  
            - Sent several friend request among Users  
            - Accepted some of the friend requests    
            - Modified interests and other user information for all of the users    

