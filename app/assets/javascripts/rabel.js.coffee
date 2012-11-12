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
  $("form.navbar-search").submit () ->
      search_input = $("#q");
      query = search_input.val()
      return if query.length == 0
      domain = search_input.data('domain')
      window.open window.rabel.search_engine_url + "site:#{domain}%20#{query}"
      false

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
    $.smoothScroll({speed: 800, scrollTarget: '#comment_content'})
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
    $.post("/topics/preview.text", {content: preview_content, type: type}, (data) ->
      ref_obj.hide()
      $("#preview").html(data).show()
      $("#preview").css('border', '1px dotted #ccc')
      $("#preview").css('background', 'lightyellow')
      $("#preview").css('padding', '10px')
      $("a.preview").addClass('current_label')
      $(".cancel_preview").removeClass('current_label')
    )
  $("a.cancel_preview").click ->
    content_id = $(this).data('ref')
    ref_obj = $("#" + content_id)
    $("#preview").hide()
    ref_obj.show()
    ref_obj.focus()
    $(this).addClass('current_label')
    $("a.preview").removeClass('current_label')

  $(".track_event").click ->
    window.rabel.trackEvent($(this).data('category'), $(this).data('action'), $(this).data('label'))

  $(".hoverable").mouseenter ->
    $(this).find('.hover_action').fadeIn()
  .mouseleave ->
    $(this).find('.hover_action').fadeOut()

  if window.location.hash.length > 0
    hashbang = window.location.hash.split('/')
    if hashbang[0] == '#!' and hashbang[1] == 'click'
      $("##{hashbang[2]}").click()

