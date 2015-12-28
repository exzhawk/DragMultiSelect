$ ->
  for i in [0...40]
    $("<div>")
    .addClass('item')
    .html('小黄本')
    .appendTo($("#container"))

  $("#container").DragMultiSelect()
