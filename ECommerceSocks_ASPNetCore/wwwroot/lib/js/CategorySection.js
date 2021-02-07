let style = [];
let print = [];
let color = [];

$(".filter").click(function () {
    if ($(this).data("clicked") == "0") {
        $(this).removeClass("fw-bold");
        $(this).data("clicked", "1");
        $(this).data("active", "0");
    } else {
        $(this).addClass("fw-bold");
        $(this).data("clicked", "0");
        $(this).data("active", "1");
    }
    getFilterParms();
    filter();
});

$(".filter-color").click(function () {
    if ($(this).data("clicked") == "0") {
        $(this).children("svg").children("circle").removeClass("stroke-black");
        $(this).data("clicked", "1");
        $(this).data("active", "0");
    } else {
        $(this).children("svg").children("circle").addClass("stroke-black");
        $(this).data("clicked", "0");
        $(this).data("active", "1");
    }
    getFilterParms();
    filter();
});

function getFilterParms() {
    style = [];
    print = [];
    color = [];
    $("#collapse_style ul li").each(function () {
        if ($(this).children("a").data("active") == "1") {
            style.push($(this).children("a").text());
        }
    });

    $("#collapse_pattern ul li").each(function () {
        if ($(this).children("a").data("active") == "1") {
            print.push($(this).children("a").text());
        }
    });

    $("#collapse_color .filter-color").each(function () {
        if ($(this).data("active") == "1") {
            color.push($(this).children("svg").children("circle").attr("fill"));
        }
    });
}