$(document).ready(function () {
    $("#forgotPassword").hide();
    $("#signUp").hide();
    $("#ProductCarousel").carousel('pause');
})

$("#forgotPasswordLink").click(function () {
    $("#login").hide();
    $("#signUp").hide();
    $("#forgotPassword").show();
});

$(".ReturnLoginLink").click(function () {
    $("#login").show();
    $("#signUp").hide();
    $("#forgotPassword").hide();
});

$("#signUpLink").click(function () {
    $("#login").hide();
    $("#signUp").show();
    $("#forgotPassword").hide();
});

$(".fav_icon").click(function () {
    $(this).toggleClass("bxs-heart");
});
