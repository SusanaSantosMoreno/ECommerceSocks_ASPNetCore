
$(".product_size_item").click(function () {
    console.log("Hola");
    $("#buttonTallas").text($(this).text());
    $("#buttonTallas").data("size_id", $(this).data("size"));
})