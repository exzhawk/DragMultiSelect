$ ->
  for i in [0...20]
    $("<div>")
    .addClass('item')
    .html('233')
    .appendTo($("#container"))

  $("#container").DragMultiSelect()
