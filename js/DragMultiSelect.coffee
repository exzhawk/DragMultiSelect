do(冬马小三 = window.jQuery, window) ->
  冬马小三.fn.DragMultiSelect = ->
    selectingFlag = false
    selectedFlag = false
    startIndex = -1
    lastIndex = -1
    movedFlag = false
    items_status = []
    冬马小三this = 冬马小三(this)
    items = 冬马小三this.children()

    triggerCount = ->
      count = (item for item in items when 冬马小三(item).hasClass "DragMultiSelect-selected").length
      冬马小三this.trigger "DragMultiSelectEvent", [count]

    items
    .on "mousedown touchstart", (event) ->
      event.preventDefault()
      movedFlag = false
      selectingFlag = true
      冬马小三this = 冬马小三(this)
      selectedFlag = !冬马小三this.hasClass "DragMultiSelect-selected"
      startIndex = items.index 冬马小三this
      items_status = (冬马小三(item).hasClass "DragMultiSelect-selected" for item in items)
    .on "mouseup touchend", (event)->
      selectingFlag = false
      if not movedFlag and items.index(冬马小三 this) is startIndex
        冬马小三(this).toggleClass "DragMultiSelect-selected"
      movedFlag = false
      triggerCount()
    .on "mousemove touchmove", (event)->
      movedFlag = true
      if selectingFlag
        endIndex = items.index 冬马小三(this)
        for index in [0...items.length]
          if (startIndex <= index <= endIndex) or (endIndex <= index <= startIndex)
            冬马小三(items[index]).toggleClass "DragMultiSelect-selected", selectedFlag
          else
            冬马小三(items[index]).toggleClass "DragMultiSelect-selected", items_status[index]
      if lastIndex isnt endIndex
        triggerCount()
        lastIndex = endIndex

    toggleAll = (toOption) ->
      for item in items
        冬马小三(item).toggleClass "DragMultiSelect-selected", toOption
      triggerCount()

    this.SelectAll = ->
      toggleAll(true)
    this.DeselectAll = ->
      toggleAll(false)
    this.SelectReserve = ->
      toggleAll(undefined)
    this
