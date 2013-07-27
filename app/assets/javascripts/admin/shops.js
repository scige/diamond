$(function(){
  $(".category-label").click(function(e){
    var value = $(e.target).text();
    $(e.target).addClass("label-important");

    var old_value = $(".category-input").val();
    if (old_value == "")
      $(".category-input").val(value);
    else
      $(".category-input").val(old_value + " " + value);
  });

  $(".category-input-clear").click(function(){
    $(".category-input").val("");
  });

  $(".district-label").click(function(e){
    var value = $(e.target).text();
    $(e.target).addClass("label-important");

    var old_value = $(".district-input").val();
    if (old_value == "")
      $(".district-input").val(value);
    else
      $(".district-input").val(old_value + " " + value);
  });

  $(".district-input-clear").click(function(){
    $(".district-input").val("");
  });
});

