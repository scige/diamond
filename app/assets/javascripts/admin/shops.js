$(function(){
  $(".category-label").click(function(e){
    var value = $(e.target).text();
    $(e.target).addClass("label-important");

    var old_value = $(".category-input").val();
    $(".category-input").val(old_value + " " + value);
  });

  $(".category-input-clear").click(function(){
    $(".category-input").val("");
  });
});

