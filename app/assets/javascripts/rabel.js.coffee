window.rabel = {}
window.rabel.trackEvent = (category, action, label) ->
  try
    _gaq.push ['_trackEvent', category, action, label]
  catch error

jQuery ($) ->
  window.rabel.sortable = (selector, update_path, options) ->
    options ||= {}
    settings =
      stop: (event, ui) ->
        $.post(update_path, $(this).sortable('serialize', {key: 'position[]'}), ->
          $(ui.item).parent().effect('highlight')
        )
    $.extend(settings, options)
    $(selector).sortable(settings)

  $(".highlight").mouseenter ->
    $(this).css('background', '#f0f0f0')
  .mouseleave ->
    $(this).css('background', '')
  $("textarea").elastic()
  $("#Search input").keyup (ev) ->
    if ev.which == 13
      query = $(this).val()
      return if query.length == 0
      domain = $(this).data('domain')
      window.open "#{window.rabel.search_engine_url}site:#{domain}%20#{query}"

  focus_comment_box = ->
    $("#comment_content").focus()

  $(".fix_cell").find(".cell:last").addClass("inner").removeClass("cell")
  $(".mention_button").click ->
    mention = $(this).data('mention')
    current_content = $("#comment_content").val()
    new_content = ''
    if current_content.length > 0
      new_content = current_content + "\n" + mention + ' '
    else
      new_content = mention + ' '
    focus_comment_box().val(new_content)
  $(".jump_to_comment").click ->
    $.smoothScroll({speed: 700, scrollTarget: '.reply_content:last'})
    focus_comment_box()
  $(".back_to_top").click ->
    $.smoothScroll({speed: 700, scrollTarget: '#Top'})

  $("a.preview").click ->
    ref_obj = $("#" + $(this).data('ref'))
    preview_content = ref_obj.val()
    if preview_content.length == 0
      ref_obj.focus()
      return

    type = $(this).data('type')
    $.post("/topics/preview", {content: preview_content, type: type}, (data) ->
      ref_obj.hide()
      $("#preview").html(data).show()
      $("#preview").css('border', '1px dotted #ccc')
      $("#preview").css('background', 'lightyellow')
      $("#preview").css('padding', '10px')
      $("a.preview").hide()
      $(".cancel_preview").show()
    )
  $("a.cancel_preview").click ->
    content_id = $(this).data('ref')
    ref_obj = $("#" + content_id)
    $("#preview").hide()
    ref_obj.show()
    ref_obj.focus()
    $("a.preview").show()
    $(this).hide()

  $(".track_event").click ->
    window.rabel.trackEvent($(this).data('category'), $(this).data('action'), $(this).data('label'))

  $.datepicker.setDefaults($.datepicker.regional['zh-CN'])
  $(".datepicker").datepicker({showButtonPanel: true})

  $(".hoverable").mouseenter ->
    $(this).find('.hover_action').fadeIn()
  .mouseleave ->
    $(this).find('.hover_action').fadeOut()

  if window.location.hash.length > 0
    hashbang = window.location.hash.split('/')
    if hashbang[0] == '#!' and hashbang[1] == 'click'
      $("##{hashbang[2]}").click()

