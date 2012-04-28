function get_angle() {
  $.get("/angle", function(angle) {
    console.log("Received angle " + angle);
    $("#hand").css("-webkit-transform", "rotate(" + angle + "deg)");
  });
}

function poll() {
  $.doTimeout(60000, get_angle);
}

$(document).ready(function(){
  $(".location").each(function(){
    var angle = $(this).attr("data-rotation");
    $(this).css("-webkit-transform", "rotate(" + angle + "deg)");
  });

  poll();
});
