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

  $("#path-form").submit (event)->
    $("#go").click()
    event.preventDefault();
    
  speed = 0
  triggerBound = 200
  autoScroll = ->
    $("main")[0].scrollTop += speed * 10
    setTimeout(autoScroll, 10)
  autoScroll()
  relativeSpeed = (0.5 + Math.cos(i / triggerBound * Math.PI) / 2 for i in [0...triggerBound + 1])
  $("main").on "mousemove", (event) ->
    mouse_pos = event.clientY
    $this = $(this)
    position = $this.position()
    topOffset = mouse_pos - position.top
    bottomOffset = position.top + $this.height() - mouse_pos
    if topOffset < triggerBound
      speed = -relativeSpeed[topOffset]
    else if bottomOffset < triggerBound
      speed = relativeSpeed[bottomOffset]
    else
      speed = 0
  .on "mouseout", ->
    speed = 0




