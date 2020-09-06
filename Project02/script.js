$(document).ready(function(){   

    $(".div-dot3").click(function (e) { 
        $('html, body').animate(
            {
              scrollTop: 0
            },
            1000
        );
    });

    $(".logo").click(function (e) {
        window.location=$(this).data('web');
    });

    $("div.circle").click(function (e) { 
        e.preventDefault();
        var upperError=$("#navigator").height()+5.558273*$("#headerDivider").height();
        $('html, body').animate(
            {
              scrollTop: $($(this).data("separator")).position().top-upperError
            },
            1000
        );
    });

    $("div.circle").hover(function () {
            $(this).css("background-color","lightgray")
        }, function () {
            $(this).css("background-color","transparent")
        }
    );
    
    $(".logo").hover(function () {
            $(this).css('border-color', 'goldenrod');
        }, function () {
            $(this).css('border-color', 'lightgray');
        }
    );

    $("#fadeMcMaster").hover(function () {
        $(".locUni").fadeIn(100)
    }, function () {
        $(".locUni").fadeOut(100)
    }

    
);

$(".projectCircle").hover(function () {
    $(this).css({"background-color": "goldenrod"});
}, function () {
    $(this).css({"background-color": "darkgray"});
}


);


//----->




function viewportWidthOf(a){
    var viewportWidth = $(window).width();
    return ((a / viewportWidth) * 100);
}

var tempVisualSort=0;
var counterVisualSort=0;

$("#proj3").click(function (e) { 
    e.preventDefault();

    if (counterVisualSort%2==0){
        $("#visual-sort").show(500);
        $("#proj3").text("-");
        $("#projects").animate({
            height: '+='+"29.8"+'vw'
          });
          counterVisualSort++;
    }
    else{
        $("#visual-sort").hide(500);
        $("#proj3").text("+");
        $("#projects").animate({
            height: '-='+"29.8"+'vw'
          });
          counterVisualSort++;
    }
});

var tempSocialMed=0;
var counterSocialMed=0;

$("#proj4").click(function (e) { 
    e.preventDefault();

    if (counterSocialMed%2==0){
        $("#social-media-site").show(500);
        $("#proj4").text("-");
        $("#projects").animate({
            height: '+='+"29.8"+'vw'
          });
          counterSocialMed++;
    }
    else{
        $("#social-media-site").hide(500);
        $("#proj4").text("+");
        $("#projects").animate({
            height: '-='+"29.8"+'vw'
          });
          counterSocialMed++;
    }
});

var tempChess=0;
var counterChess=0;

$("#proj1").click(function (e) { 
    e.preventDefault();

    if (counterChess%2==0){
        $("#chess").show(500);
        $("#proj1").text("-");
        $("#projects").animate({
            height: '+='+"43.8"+'vw'
          });
        counterChess++;
    }
    else{
        $("#chess").hide(500);
        $("#proj1").text("+");
        $("#projects").animate({
            height: '-='+"43.8"+'vw'
          });
        counterChess++;
    }
});


var tempTour=0;
var counterTour=0;


$("#proj2").click(function (e) { 
    e.preventDefault();

    if (counterTour%2==0){
        $("#tournament").show(500);
        $("#proj2").text("-");
        $("#projects").animate({
            height: '+='+"31"+'vw'
          });
        counterTour++;
    }
    else{
        $("#tournament").hide(500);
        $("#proj2").text("+");
        $("#projects").animate({
            height: '-='+"31"+'vw'
          });
        counterTour++;
    }
});


//<-----

$(".awb").click( function (e) {
    var isClosed=$(this).html();
    var extraMargin=Math.round($(this).siblings(".aw").height()*0.90);
    if (isClosed=='+'){
        $("#contAw").animate({"margin-bottom":"+="+extraMargin+"px"},500);
        $(this).data("extraMargin",extraMargin);
        $(this).siblings(".aw").show(500);
        $(this).html("-");
    }
    else{
        var extraMargin=$(this).data('extraMargin');
        $("#contAw").animate({"margin-bottom":"-="+extraMargin+"px"},500);
        $(this).html("+");
        $(this).siblings(".aw").hide(500);
    }

});



var lang=false;
var skills=false;
var robotics=false;
var ebc=false;
var timmies = false;
var nsc = false;
var bar=false;
var r=220;
var g=20;
var incr=30;
var delayFinished=false;

    $(document).on('scroll', function() {
        var headerError=$("#navigator").height()+7*$("#headerDivider").height();

        if ($(this).scrollTop()>=$('#welcome').position().top/1.75){
            $("#name,.divider1,.div-transparent1,.div-dot1").hide(600);
        }
        else if ($(this).scrollTop()<=$('#welcome').position().top/1.75){
            $("#name,.divider1,.div-transparent1,.div-dot1").show(600);
        }

        if ($(this).scrollTop()>=$("#aboutMeDivider").position().top-headerError && lang==false){
                $("#eng").show().css({"background-color":"red"}).animate({"width":"+=90%"},800);
                $("#rus").delay(700).show().css({"background-color":"red"}).animate({"width":"+=90%"},800);
                $("#ukr").show().css({"background-color":"red"}).delay(1400).animate({"width":"+=90%"},800);
                lang=true;
        }



        if ($(this).scrollTop()>=$("#educationDivider").position().top-headerError && bar==false){
            $(".bar").animate({width:"+=19%"},3000,() => {$(".circle1").css({border: '0.3vw solid green'});$(".bar").animate({width:"+28%"},500)});
            $(".circle1").css({border: '0.2vw solid red'}).animate({
                borderWidth: "0.3vw"
            }, 1500);
            bar=true;
        }
        
        if ($(this).scrollTop()>= $("#workDivider").position().top-headerError && timmies==false && nsc==false){
            $("#timmies").fadeIn(1500);
            timmies=true;
            $("#nsc").fadeIn(1500);
            nsc=true
        }
        
        if ($(this).scrollTop()>= $("#volunteerDivider").position().top-headerError && ebc==false){
            $("#ebc").fadeIn(1500);
            ebc=true;
        }

        if ($(this).scrollTop()>= $("#extracurDivider").position().top-headerError && robotics==false){
            $("#robotics").animate({"marginLeft":"-=10%"},1000);
            robotics=true;
        }

        if ($(this).scrollTop()>= $("#skillsDivider").position().top-headerError && skills==false){ // colorful skills
            skills=true;
            $(".skills li").each(function (i,elem) {
                        setTimeout(function () {
                        $(elem).css("color", "black");
                        delayFinished=true;
                        }, 2500);
                    $(this).hide().delay(i*100).fadeIn(100);
                    if (i==9){r=220; g=80;incr=0; }
                    else if (i==12 ){r=220; g=20;incr=40;}
                    else if (i==19){r=220;g=20; incr=40;
                    }

                    if (g<220){g+=incr;}
                    else{r-=incr;}
                    $(this).css("color","rgba("+r+","+g+", 32, 0.796)").data('color',"rgba("+r+","+g+", 32, 0.796)");

            }).hover(function () {
                $(this).css({
                    color: $(this).data('color'),
                    "font-weight":'bold'
                })
            }, function () {
                if (delayFinished ==false){$(this).css({color: $(this).data('color'),"font-weight":'normal'});}
                else{$(this).css({color:'black',"font-weight":'normal'});}
            });
        
        }


        
    });


    $("#me").animate({"marginLeft":"+=5%"},600);
    $(".skills li").hide();
  });
