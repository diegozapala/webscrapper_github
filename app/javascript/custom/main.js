$(document).ready(function () {

  eventRescan()

})

function eventRescan() {
  $(".btn_box.rescan, .btn_box_mobile.rescan").click(function(e) {
    doStartLoader()
  })
}

function doStartLoader() {
  $(".page").append("<div class='loaders loaders_primary all'><div class='loader_icon medium'></div></div>")
}
