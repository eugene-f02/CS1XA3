// TODO CKECK IF NEW PASS = OLD PASS!!
$(document).ready(function() {

    var form_completed_pass=false
    var form_completed_info=false
    var valid_new_interest=false

    $(document).on('click', '[id^=remove]', function(e){
        e.preventDefault();
        thisId=$(this).attr('id').slice(6);
        $.post('/e/fedorivy/social/account/'
        ,{ 'id' : thisId,
           'type': "removeBut",
           'fromButton':"True",
        }
        ,function(data,status){
            $("#interestAdded").html("");
            $("#interestAdded").html("Successfully updated").css('color', 'green');
            $("[id='remove"+data['id']+"']").remove();
            $("[id='labelRemove"+data['id']+"']").remove();
            $("[id='interest"+data['id']+"']").remove();
            if ($('#newInterest').val()==data['id']) valid_new_interest=true
        }
       );
    
    });

    $("#addBut").click(function(){
        if (valid_new_interest) {
        let newInterest = $("#newInterest").val();
        $.post('/e/fedorivy/social/account/'
        ,{ 'newInterest' : newInterest,
           'type': "interest",
        }
        ,function(data,status) {
            $('#newInterest').val("");
            $("#interestAdded").html("Successfully updated").css('color', 'green');
            $( "#allInterests" ).append('<span id="interest'+data['new']+'" class="w3-tag w3-small w3-theme-d5">'+data['new']+"</span> ");
            $("#subBlockInterests").append('<span id="labelRemove'+data['new']+'" class="w3-tag w3-small w3-theme-d5">'+data['new']+'</span> <button id="remove'+data['new']+'">Remove</button><p></p>');
            valid_new_interest=false

        }
       );


      }
    });


    $("#userInfo").submit(function (e) {
        e.preventDefault();
        if (form_completed_info){
        let form = $(this);
        let employment = form.find("input[name='employment']").val();
        let location = form.find("input[name='location']").val();
        let birthday = form.find("input[name='birthday']").val();
        $.post('/e/fedorivy/social/account/'
        ,{ 'employment' : employment,
           'location' : location,
           'birthday' : birthday,
           'type': "info",
           'fromButton':"True",
        }
        ,function(data,status){

            if (data['allEmpty']==true){
                $("#successInfoChange").html("")
            }
            else{
                    if (data["BD_Format"]=="Fail") {
                        form_completed_info=false;
                        $("#successInfoChange").html("Invalid Date").css('color', 'red');
                    }
                    else{
                    let newInterest = $("#newInterest").val();
                    $("#userInfo")[0].reset();
                    $("#newInterest").val(newInterest);
                    $("#successInfoChange").html("Successfully updated").css('color', 'green');
                    for (key in data){
                        if (data[key]!="") $("#"+key).html(data[key]);
                    }
                }
            }

        }
       );

    }

    });


    $("#userInfo").change(function(e){
        let form = $(this);
        let employment = form.find("input[name='employment']").val();
        let location = form.find("input[name='location']").val();
        let birthday = form.find("input[name='birthday']").val();
        let newInterest = $("#newInterest").val();
        $.post('/e/fedorivy/social/account/'
        ,{ 'employment' : employment,
           'location' : location,
           'birthday' : birthday,
           'newInterest' : newInterest,
           'type': "info",
           'fromButton':"False",
     }
        ,function(data,status){
            if (data["BD_Format"]=="Fail") {
                form_completed_info=false;
                $("#successInfoChange").html("YYYY-MM-DD format").css('color','red');
            }
            else {
                $("#successInfoChange").html("");
                form_completed_info=true;
            }

            if (data['taken']=="False") {
                valid_new_interest=true;
                $("#interestAdded").html("");
                }
                else if (data['taken']=="True"){
                    valid_new_interest=false;
                    $("#interestAdded").html("Already exists").css('color','red');
                }
                else{
                    valid_new_interest=false;
                    $("#interestAdded").html("");
                }
        }
        );

    });



    $("#changePass").submit(function (e) {
        e.preventDefault();
        if (form_completed_pass){
            let form = $(this);
            let oldPass = form.find("input[name='currentPassword']").val();
            let pass = form.find("input[name='newPassword']").val();
            let confpass = form.find("input[name='confNewPassword']").val();
            $.post('/e/fedorivy/social/account/'
                   ,{ 'currentPassword' : oldPass,
                      'newPassword' : pass,
                      'confNewPassword' : confpass,
                      'type':'newPass',
                      'fromButton':"True",
                },function(data,status){
                    $("#changePass")[0].reset();
                    $("#successPassChange").html("Password has been successfully updated");

                });
        }
    });
    
    $("#changePass").change(function(){
        $("#successPassChange").html("");
        let form = $(this);
        let oldPass = form.find("input[name='currentPassword']").val();
        let pass = form.find("input[name='newPassword']").val();
        let confpass = form.find("input[name='confNewPassword']").val();
        $.post('/e/fedorivy/social/account/'
               ,{ 'currentPassword' : oldPass,
                  'newPassword' : pass,
                  'confNewPassword' : confpass,
                  'type':'newPass',
                  'fromButton':"False",
            }
               ,function(data,status) {
                    
                if (data['valid'])  form_completed_pass=true;
                else form_completed_pass=false;


                   if (data["currentPassNotMatch"]==true && oldPass!='') $("#wrongCurrPass").html("Wrong current password");
                   else{
                    $("#wrongCurrPass").html("");
                    if (data["acceptableLength"]==false && pass!='')  $("#NewPass").html("Password has to be at least 8 characters long");
                    else if (data["specialChar"]==false && pass!='')  $("#NewPass").html("Password has to contain at least one special character <p></p> (i.e. !\"#$%&'()*+,-./:;<=>?@[\]^_`{|}~ ) ");
                    else if (data["lowerChar"]==false && pass!='')  $("#NewPass").html("Password has to contain at least one lowercase character");
                    else if (data["upperChar"]==false && pass!='')  $("#NewPass").html("Password has to contain at least one uppercase character");
                    else if (data["numericChar"]==false && pass!='')  $("#NewPass").html("Password has to contain at least one numeric character");
                    else if (data["NotIdentical"]==false && pass!='')  $("#NewPass").html("Cannot use current password");      
                    else {
                        $("#NewPass").html("")
                        if (data["confirmationSuccess"]==false && confpass!='')  $("#NewConfirmPass").html("Passwords do not match")
                        else {
                            $("#NewConfirmPass").html("");
                        }
                    }
                   }
        
               }
              );
    });













   });
