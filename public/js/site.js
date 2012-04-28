function get_angle() {
  $.get("/angle", function(angle) {
    console.log("Received angle " + angle);
    $("#hand").css("-webkit-transform", "rotate(" + angle + "deg)");
  });
  setTimeout("get_angle()", 10000);
}

$(document).ready(function(){
  $(".location").each(function(){
    var angle = $(this).attr("data-rotation");
    $(this).css("-webkit-transform", "rotate(" + angle + "deg)");
  });

  get_angle();
});
