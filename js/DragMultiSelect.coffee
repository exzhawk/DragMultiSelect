$.fn.DragMultiSelect = ->
  selectingFlag = false
  selectedFlag = false
  startIndex = -1
  lastIndex=-1
  movedFlag=false
  items_status = []
  $this=$(this)
  items = $this.children()
  triggerCount = ->
    count = 0
    for item in items
      if $(item).hasClass("selected")
        count += 1
    $this.trigger("DragMultiSelectEvent", [count])
  items
  .on "mousedown touchstart", (event) ->
    event.preventDefault()
    movedFlag=false
    selectingFlag = true
    $this = $(this)
    selectedFlag = !$this.hasClass("selected")
    startIndex = items.index($this)
    for item,index in items
      items_status[index] = $(item).hasClass("selected")
  .on "mouseup touchend", (event)->
    selectingFlag = false
    if !movedFlag and items.index($(this)) == startIndex
      $(this).toggleClass("selected")
    movedFlag=false
    triggerCount()
  .on "mousemove touchmove", (event)->
    movedFlag=true
    if selectingFlag
      endIndex = items.index($(this))
      for index in [0...items.length]
        if (index <= endIndex and index >= startIndex) or (index >= endIndex and index <= startIndex)
          $(items[index]).toggleClass("selected", selectedFlag)
        else
          $(items[index]).toggleClass("selected", items_status[index])
    if lastIndex!=endIndex
      triggerCount()
      lastIndex=endIndex
  this