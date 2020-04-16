/* ********************************************************************************************
   | Handle Submitting Posts - called by $('#post-button').click(submitPost)
   ********************************************************************************************
   */
function  submitPost_callback(data){
 location.reload();
}

function submitPost(event) {
    let path = post_submit_url
    let json_data ={"postContent":$("#post-text").html()}
    $.post(path,
        json_data,
        submitPost_callback);

    // TODO Objective 8: send contents of post-text via AJAX Post to post_submit_view (reload page upon success)
}

function submitLike_callback(data){
    if (data['totalLikes']==1) $("#numOfLikes-"+data['butId']).html(data['totalLikes']+" Like")
    else $("#numOfLikes-"+data['butId']).html(data['totalLikes']+" Likes")
    $("#post-"+data['butId']).prop('disabled',true)
    if (data['success']==true){
        $("#likedSuccess-"+data['butId']).html("Successfully liked the post").css("margin-left","30px").css("color",'green')
    }
    else $("#likedSuccess-"+data['butId']).html("This post has been already liked").css("margin-left","30px").css("color",'red')


}
/* ********************************************************************************************
   | Handle Liking Posts - called by $('.like-button').click(submitLike)
   ********************************************************************************************
   */
function submitLike(event) {
    id=($(this).attr('id')).slice(5)
    let path = like_post_url
    let json_data ={"postID":id}
    $.post(path,
        json_data,
        submitLike_callback);
    // TODO Objective 10: send post-n id via AJAX POST to like_view (reload page upon success)
}

/* ********************************************************************************************
   | Handle Requesting More Posts - called by $('#more-button').click(submitMore)
   ********************************************************************************************
   */
function moreResponse(data,status) {
    if (data['success']) location.reload();
    else  $("#more-button").prop('disabled',true);
}

function submitMore(event) {
    // submit empty data
    let json_data = { };
    // globally defined in messages.djhtml using i{% url 'social:more_post_view' %}
    let url_path = more_post_url;

    // AJAX post
    $.post(url_path,
           json_data,
           moreResponse);
}

/* ********************************************************************************************
   | Document Ready (Only Execute After Document Has Been Loaded)
   ********************************************************************************************
   */
$(document).ready(function() {
    // handle post submission
    $('#post-button').click(submitPost);
    // handle likes
    $('.like-button').click(submitLike);
    // handle more posts
    $('#more-button').click(submitMore);
});
