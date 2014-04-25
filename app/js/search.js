(function() {
  jQuery(function() {
    var attr, key, radioAttrs, radioHtml, searchHtml, searchTextBefore, style;
    style = "height: 30px; font: bold 20px Helvetica;";
    radioAttrs = {
      task: {
        value: 1,
        name: "タスク"
      },
      timeLine: {
        value: 2,
        name: "タイムライン"
      }
    };
    radioHtml = '';
    for (key in radioAttrs) {
      attr = radioAttrs[key];
      radioHtml += "<input type=" + "radio" + " id=\"search_" + attr.value + "\" name=\"search_type\" value=\"" + attr.value + "\">\n<label for=" + ("search_" + attr.value) + ">" + attr.name + "</label>";
    }
    searchHtml = '<div style="' + style + '">' + '<input type="text" id="search_text" placeholder="search..."></div>';
    $(searchHtml + radioHtml).prependTo('body');
    $("#search_" + radioAttrs.timeLine.value).attr('checked', 'checked');
    searchTextBefore = "";
    return $('#search_text').keydown(function(event) {
      var searchText, searchType;
      searchType = parseInt($('input[name=search_type]:checked').val(), 10);
      searchText = $('#search_text').val();
      if (searchType === radioAttrs.task.value) {
        if (searchTextBefore !== "") {
          $('#_subRoomTaskList').find('li').not(":contains(" + searchTextBefore + ")").each(function() {
            return $(this).show();
          });
        }
        if (searchText !== "") {
          $('#_subRoomTaskList').find('li').not(":contains(" + searchText + ")").each(function() {
            return $(this).hide();
          });
        }
      } else if (searchType === radioAttrs.timeLine.value) {
        if (searchTextBefore !== "") {
          $('#_timeLine').find('._chatTimeLineMessageBox.chatTimeLineMessageInner').not(":contains(" + searchTextBefore + ")").each(function() {
            return $(this).show();
          });
        }
        if (searchText !== "") {
          $('#_timeLine').find('._chatTimeLineMessageBox.chatTimeLineMessageInner').not(":contains(" + searchText + ")").each(function() {
            return $(this).hide();
          });
        }
      }
      return searchTextBefore = searchText;
    });
  });

}).call(this);
