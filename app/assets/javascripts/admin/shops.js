$(function(){
  $(".category-label").click(function(e){
    if ($(e.target).hasClass("label-important"))
    {
      return;
    }

    var value = $(e.target).text();
    $(e.target).addClass("label-important");

    var old_value = $(".category-input").val();
    if (old_value == "")
      $(".category-input").val(value);
    else
      $(".category-input").val(old_value + " " + value);
  });

  $(".category-input-clear").click(function(e){
    $(".category-input").val("");
    $(".category-label").removeClass("label-important");
  });

  $(".district-label").click(function(e){
    if ($(e.target).hasClass("label-important"))
    {
      return;
    }

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
    $(".district-label").removeClass("label-important");
  });
});

