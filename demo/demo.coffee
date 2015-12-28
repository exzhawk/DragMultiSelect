$ ->
  for i in [0...40]
    $("<div>")
    .addClass('item')
    .html('bgm38')
    .appendTo($("#container"))

  $("#container").DragMultiSelect()
