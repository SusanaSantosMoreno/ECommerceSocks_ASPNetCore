
$(".product_size_item").click(function () {
    $("#sizesBtn").text($(this).text());
    $("#sizesBtn").data("size_id", $(this).data("size"));

    if ($("#sizesBtn").text().trim() != "SIZES") {
        $("#addToCartBtn").prop('disabled', false);
    } else {
        $("#addToCartBtn").prop('disabled', true);
    }
});
