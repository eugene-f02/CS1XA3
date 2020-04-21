
$(document).ready(function() {

    var form_completed=false


    $("#signup_form").submit(function (e) {
        return form_completed
    });


    
    $("#signup_form").change(function(){
  
        let form = $(this);
        let name = form.find("input[name='username']").val().trim();
        $("input[name='username']").val(name);
        let pass = form.find("input[name='password']").val();
        let confpass = form.find("input[name='confPass']").val();
        $.post('/e/fedorivy/signup/'
               ,{ 'username' : name,
                  'password' : pass,
                  'confPass' : confpass
            }
               ,function(data,status) {
                    
                if (data['valid'])  form_completed=true;
                else form_completed=false;


                   if (data["userExists"]==true) $("#userExists").fadeIn().html("This username already exists. Please use a different username");
               
                    
                    else if (data['emptyName']==true) $("#userExists").fadeIn().html("Username cannot be empty or consist solely of whitespace characters")

                    else{
                    $("#userExists").fadeOut();
                    if (data["acceptableLength"]==false && pass!='')  $("#pass").fadeIn().html("Password has to be at least 8 characters long");
                    else if (data["specialChar"]==false && pass!='')  $("#pass").fadeIn().html("Password has to contain at least one special character <p></p> (i.e. !\"#$%&'()*+,-./:;<=>?@[\]^_`{|}~ ) ");
                    else if (data["lowerChar"]==false && pass!='')  $("#pass").fadeIn().html("Password has to contain at least one lowercase character");
                    else if (data["upperChar"]==false && pass!='')  $("#pass").fadeIn().html("Password has to contain at least one uppercase character");
                    else if (data["numericChar"]==false && pass!='')  $("#pass").fadeIn().html("Password has to contain at least one numeric character");
                    else {
                        $("#pass").fadeOut()
                        if (data["confirmationSuccess"]==false && confpass!='')  $("#confirmPass").fadeIn().html("Passwords do not match")
                        else {
                            $("#confirmPass").fadeOut();
                        }
                     }


                   }
        
               }
              );
    });
   });
