# 引数なし関数
jQuery ->
  # varを自動でつけるため不要
  # 絞り込み検索用フォーム
  style      = "height: 30px; font: bold 20px Helvetica;"
  radioAttrs = {
    task    : {value: 1, name: "タスク"}
    timeLine: {value: 2, name: "タイムライン"}
  }
  radioHtml = '' # シングルでもOK
  for key, attr of radioAttrs
    # =#{}が代入になるためヒアドキュメントで対応
    # ラベルの書き方だとエスケープにならない
    radioHtml += """<input type=#{"radio"} id="search_#{attr.value}" name="search_type" value="#{attr.value}">
                    <label for=#{"search_#{attr.value}"}>#{attr.name}</label>
                 """

  # +で文字列連結
  searchHtml = '<div style="' + style + '">' + '<input type="text" id="search_text" placeholder="search..."></div>'
  $(searchHtml + radioHtml).prependTo('body')

  # タイムライン絞り込みをデフォルトにする
  $("#search_#{radioAttrs.timeLine.value}").attr('checked', 'checked');

  # 引数付き関数
  # キーイベント
  searchTextBefore = ""
  $('#search_text').keydown (event) ->
    searchType = parseInt($('input[name=search_type]:checked').val(), 10)
    searchText = $('#search_text').val()

    # 絞込み前に前回の非表示項目を再表示
    if searchType is radioAttrs.task.value
      unless searchTextBefore is ""
        $('#_subRoomTaskList').find('li').not(":contains(#{searchTextBefore})").each(->
          $(@).show()
        )
      unless searchText is ""
        $('#_subRoomTaskList').find('li').not(":contains(#{searchText})").each(->
          $(@).hide()
        )
    else if searchType == radioAttrs.timeLine.value
      # 等号は === になる
      unless searchTextBefore == ""
        $('#_timeLine').find('._chatTimeLineMessageBox.chatTimeLineMessageInner').not(":contains(#{searchTextBefore})").each(->
          $(@).show()
        )
      unless searchText is ""
        $('#_timeLine').find('._chatTimeLineMessageBox.chatTimeLineMessageInner').not(":contains(#{searchText})").each(->
          $(@).hide()
        )

    searchTextBefore = searchText
