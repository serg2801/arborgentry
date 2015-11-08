$(document).ready(function() {

    var wW = $(window).width();
    var wH = $(window).height();
    var LW = $("#logo").width();
    var setLeft = wW - LW;
    $("#logo").css("left", setLeft / 2 + "px");
    var pH = $(".page-wrap").height();
    $("#sidebar").height(pH);


    if (wW < 768) {
        var listWidth = $(".footer-top-links ul").width();
        var setM = (wW - listWidth) / 2;
        $(".footer-top-links ul").css("margin-left", setM + "px");

        $("#side-bar-toggle-btn").click(function() {
            var cl_name = $("#sidebar").attr("class");
            if (cl_name == "open") {
                $("#sidebar").animate({
                    "left": "-300px"
                });
                $("#sidebar").removeClass('open');
            } else {
                $("#sidebar").animate({
                    "left": "0px"
                });
                $("#sidebar").addClass('open');
            }
        });
    } else {
        $("#side-bar-toggle-btn").click(function() {
            var cl_name = $("#sidebar").attr("class");
            if (cl_name == "open") {
                $("#sidebar").animate({
                    "left": "-330px"
                });
                $("#sidebar").removeClass('open');
            } else {
                $("#sidebar").animate({
                    "left": "30px"
                });
                $("#sidebar").addClass('open');
            }
        });
    }

});

$(window).resize(function() {
    var wW = $(window).width();
    var LW = $("#logo").width();
    var setLeft = wW - LW;
    $("#logo").css("left", setLeft / 2 + "px");


    if (wW < 768) {
        var listWidth = $(".footer-top-links ul").width();
        var setM = (wW - listWidth) / 2;
        $(".footer-top-links ul").css("margin-left", setM + "px");
    }
})
