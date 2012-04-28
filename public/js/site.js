$(document).ready(function(){
  $(".location").each(function(){
    var angle = $(this).attr("data-rotation");
    $(this).css("-webkit-transform", "rotate(" + angle + "deg)");
  });

  $.get("/angle", function(angle) {
    $("#hand").css("-webkit-transform", "rotate(" + angle + "deg)");
  });
});
