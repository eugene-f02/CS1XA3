/* ********************************************************************************************
   | Handle Submiting Friend Requests - called by $('.like-button').click(submitLike)
   ********************************************************************************************
   */

function acceptDeclineResponse(data){
    location.reload();
}

function frResponse(data,status) {
    if (data["success"]==true) {
       $("#fr-"+$.escapeSelector(data["id"])).prop('disabled', true);
       $("#sentReq-"+$.escapeSelector(data["id"])).html("Request has been successfully sent").css("color","green")
        //location.reload();
    }
    else {
        $("#sentReq-"+$.escapeSelector(data["id"])).html("Request has been already sent").css("color","red")
    }
}

function friendRequest(event) {
    // the id of the current button, should be fr-name where name is valid username
    let frID = event.target.id;
    let json_data = { 'frID' : frID };
    // globally defined in messages.djhtml using i{% url 'social:like_view' %}
    let url_path = friend_request_url;

    // AJAX post
    $.post(url_path,
           json_data,
           frResponse);
}

/* ********************************************************************************************
   | Handle Requesting More People - called by $('#more-ppl-button').click(submitMorePpl)
   ********************************************************************************************
   */
function morePplResponse(data,status) {
        if (data['success']) location.reload();
        else{
            $("#more-ppl-button").prop('disabled',true);
        } 
       
}

function submitMorePpl(event) {
    // submit empty data
    let json_data = {"inc": true};
    // globally defined in messages.djhtml using i{% url 'social:more_post_view' %}
    let url_path = more_ppl_url;

    // AJAX post
    $.post(url_path,
           json_data,
           morePplResponse);
}

/* ********************************************************************************************
   | Handle Accepting/Declining Friend Requests -
   |                           called by $('.acceptdecline-button').click(acceptDeclineRequest)
   ********************************************************************************************
   */

function acceptDeclineRequest(event) {
    let decision=($(this).attr("id")).slice(0,1)
    let id=($(this).attr("id")).slice(2)
    let json_data = {'id':id, 'decision':decision}
    let url_path = accept_decline_url;
    $.post(url_path,
        json_data,
        acceptDeclineResponse);

    // TODO Objective 6: perform AJAX POST to accept or decline Friend Request
}

/* ********************************************************************************************
   | Document Ready (Only Execute After Document Has Been Loaded)
   ********************************************************************************************
   */
$(document).ready(function() {
    // handle requesting more ppl
    $('#more-ppl-button').click(submitMorePpl);
    // handle for creating a friend request
    $('.fr-button').click(friendRequest);
    // handle for accepting/declining a friend request
    $('.acceptdecline-button').click(acceptDeclineRequest);
});
