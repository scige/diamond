$(function(){
  var pos_lati = $("#map-container").attr("data-latitude");
  var pos_longti = $("#map-container").attr("data-longitude");
  
  var map = new BMap.Map("map-container");
  var point = new BMap.Point(pos_longti, pos_lati);
  
  var marker1 = new BMap.Marker(new BMap.Point(pos_longti, pos_lati));
  map.addOverlay(marker1);
  
  map.centerAndZoom(point,17);
  map.enableScrollWheelZoom();
  map.addControl(new BMap.NavigationControl({type: BMAP_NAVIGATION_CONTROL_ZOOM}));
  map.addControl(new BMap.OverviewMapControl());
});

