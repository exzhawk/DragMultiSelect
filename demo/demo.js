// Generated by CoffeeScript 1.10.0
(function() {
  $(function() {
    var dragMultiSelect, initDragMultiSelect, refresh;
    dragMultiSelect = null;
    initDragMultiSelect = function() {
      dragMultiSelect = $("#container").DragMultiSelect();
      return dragMultiSelect.on("DragMultiSelectEvent", function(event, count) {
        return $("#count").attr("data-badge", count);
      });
    };
    refresh = function() {
      return $.getJSON("/browse", {
        path: $("#path").val()
      }, function(data) {
        var $container, e, i, j, len;
        $container = $("#container");
        $container.empty();
        for (j = 0, len = data.length; j < len; j++) {
          i = data[j];
          e = encodeURIComponent(i);
          $("<div>").addClass('item').attr("path", i).css("background-image", "url(/file?path=" + e + ")").appendTo($container);
        }
        $("#count").attr("data-badge", 0);
        return initDragMultiSelect();
      });
    };
    $("#go").on("click", function() {
      var i, j;
      if ($("#path").val() === "") {
        for (i = j = 0; j < 40; i = ++j) {
          $("<div>").addClass('item').appendTo($("#container"));
        }
        initDragMultiSelect();
      } else {
        refresh();
      }
      return $('main')[0].scrollTop = 0;
    });
    $("#delete").on("click", function() {
      var item, selection;
      selection = (function() {
        var j, len, ref, results;
        ref = $("#container .DragMultiSelect-selected");
        results = [];
        for (j = 0, len = ref.length; j < len; j++) {
          item = ref[j];
          results.push($(item).attr("path"));
        }
        return results;
      })();
      return $.ajax({
        url: "/delete",
        data: {
          paths: selection
        },
        method: "POST",
        success: function() {
          return refresh();
        }
      });
    });
    $("#selectAll").on("click", function() {
      return dragMultiSelect.SelectAll();
    });
    $("#deselectAll").on("click", function() {
      return dragMultiSelect.DeselectAll();
    });
    $("#selectReverse").on("click", function() {
      return dragMultiSelect.SelectReserve();
    });
    return $("#path-form").submit(function(event) {
      $("#go").click();
      return event.preventDefault();
    });
  });

}).call(this);

//# sourceMappingURL=demo.js.map
