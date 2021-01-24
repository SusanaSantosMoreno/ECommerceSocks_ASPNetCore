$(document).ready(function () {
    $("#forgotPassword").hide();
    $("#ProductCarousel").carousel('pause');
})

$("#forgotPasswordLink").click(function () {
    $("#login").hide();
    $("#forgotPassword").show();
});

$("#ReturnLoginLink").click(function () {
    $("#login").show();
    $("#forgotPassword").hide();
});

$(".fav_icon").click(function () {
    $(this).toggleClass("bxs-heart");
});