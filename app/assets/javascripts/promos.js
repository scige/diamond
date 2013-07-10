$(function(){
  $("#send-mobile").click(function(){
    var divID = $(".pop-main");
    var top = ($(window).height() - divID.height()) / 2;
    var left = ($(window).width() - divID.width()) / 2;
    divID.css({ top: top + "px", left: left + "px" });
    $(".pop-main").show(0);
  });

  $("#pop-confirm").click(function(){
    $(".pop-main").hide(0);
  });

  $("#pop-cancel").click(function(){
    $(".pop-main").hide(0);
  });
});
