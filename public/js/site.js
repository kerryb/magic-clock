$(document).ready(function(){
  $(".location").each(function(){
    console.log($(this));
    var angle = $(this).attr("data-rotation");
    console.log(angle);
    $(this).css("-webkit-transform", "rotate(" + angle + "deg)");
  });
});
