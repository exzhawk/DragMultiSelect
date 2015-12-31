$ ->
  refresh = ->
    $.getJSON "/browse", path: $("#path").val(), (data) ->
      $container = $("#container")
      $container.empty()
      for i in data
        e = encodeURIComponent(i)
        $("<div>")
        .addClass('item')
        .attr("path", i)
        .css("background-image", "url(/file?path=" + e + ")")
        .appendTo($container)
      $("#count").attr("data-badge", 0)
      dragMultiSelect = $("#container").DragMultiSelect()
      dragMultiSelect.on "DragMultiSelectEvent", (event, count)->
        $("#count").attr("data-badge", count)

  $("#go").on "click", ->
    if $("#path").val() == ""
      for i in [0...40]
        $("<div>")
        .addClass('item')
        .appendTo($("#container"))
      dragMultiSelect = $("#container").DragMultiSelect()
      dragMultiSelect.on "DragMultiSelectEvent", (event, count)->
        $("#count").attr("data-badge", count)
    else
      refresh()

  $("#delete").on "click", ->
    selection = ($(item).attr("path") for item in $("#container .selected"))
    $.ajax
      url: "/delete"
      data:
        paths: selection
      method: "POST"
      success: ->
        refresh()




