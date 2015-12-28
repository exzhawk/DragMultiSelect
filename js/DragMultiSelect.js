// Generated by CoffeeScript 1.10.0
(function() {
  $.fn.DragMultiSelect = function() {
    var items, items_status, selectedFlag, selectingFlag, startIndex;
    selectingFlag = false;
    selectedFlag = false;
    startIndex = -1;
    items_status = [];
    items = $(this).children();
    items.on("mousedown touchstart", function(event) {
      var $this, i, index, item, len, results;
      event.preventDefault();
      selectingFlag = true;
      $this = $(this);
      selectedFlag = !$this.hasClass("selected");
      startIndex = items.index($this);
      results = [];
      for (index = i = 0, len = items.length; i < len; index = ++i) {
        item = items[index];
        results.push(items_status[index] = $(item).hasClass("selected"));
      }
      return results;
    }).on("mouseup touchmove", function(event) {
      selectingFlag = false;
      if (items.index($(this)) === startIndex) {
        return $(this).toggleClass("selected");
      }
    }).on("mousemove touchend", function(event) {
      var count, endIndex, i, index, item, j, len, ref;
      if (selectingFlag) {
        endIndex = items.index($(this));
        for (index = i = 0, ref = items.length; 0 <= ref ? i < ref : i > ref; index = 0 <= ref ? ++i : --i) {
          if ((index <= endIndex && index >= startIndex) || (index >= endIndex && index <= startIndex)) {
            $(items[index]).toggleClass("selected", selectedFlag);
          } else {
            $(items[index]).toggleClass("selected", items_status[index]);
          }
        }
        count = 0;
        for (j = 0, len = items.length; j < len; j++) {
          item = items[j];
          if ($(item).hasClass("selected")) {
            count += 1;
          }
        }
        return $(this).trigger("DragMultiSelectEvent", [count]);
      }
    });
    return this;
  };

}).call(this);

//# sourceMappingURL=DragMultiSelect.js.map
