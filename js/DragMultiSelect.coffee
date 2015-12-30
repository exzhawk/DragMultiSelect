$.fn.DragMultiSelect = ->
  selectingFlag = false
  selectedFlag = false
  startIndex = -1
  lastIndex = -1
  movedFlag = false
  items_status = []
  $this = $(this)
  items = $this.children()
  triggerCount = ->
    count = 0
    for item in items
      if $(item).hasClass "selected"
        count += 1
    $this.trigger "DragMultiSelectEvent", [count]
  items
  .on "mousedown touchstart", (event) ->
    event.preventDefault()
    movedFlag = false
    selectingFlag = true
    $this = $(this)
    selectedFlag = !$this.hasClass "selected"
    startIndex = items.index $this
    items_status=($(item).hasClass "selected" for item in items)
  .on "mouseup touchend", (event)->
    selectingFlag = false
    if not movedFlag and items.index($(this)) is startIndex
      $(this).toggleClass "selected"
    movedFlag = false
    triggerCount()
  .on "mousemove touchmove", (event)->
    movedFlag = true
    if selectingFlag
      endIndex = items.index $(this)
      for index in [0...items.length]
        if (index <= endIndex and index >= startIndex) or (index >= endIndex and index <= startIndex)
          $(items[index]).toggleClass "selected", selectedFlag
        else
          $(items[index]).toggleClass "selected", items_status[index]
    if lastIndex isnt endIndex
      triggerCount()
      lastIndex = endIndex
  this