$.fn.DragMultiSelect = ->
  selectingFlag = false
  selectedFlag = false
  startIndex = -1
  items_status = []
  items=$(this).children()
  items
  .on "mousedown touchstart", (event) ->
    event.preventDefault()
    selectingFlag = true
    $this = $(this)
    selectedFlag = !$this.hasClass("selected")
    startIndex = items.index($this)
    for item,index in items
      items_status[index] = $(item).hasClass("selected")
  .on "mouseup touchmove", (event)->
    selectingFlag = false
  .on "mousemove touchend", (event)->
    if selectingFlag
      endIndex = items.index($(this))
      for index in [0...items.length]
        if (index <= endIndex and index >= startIndex) or (index >= endIndex and index <= startIndex)
          $(items[index]).toggleClass("selected", selectedFlag)
        else
          $(items[index]).toggleClass("selected", items_status[index])
  this