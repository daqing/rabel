var rabel = {
  onReady: function () {
    var _this = this;

    document.addEventListener("turbo:load", () => {
      _this.clickPreview()
      _this.cancelPreview()
    });
  },
  clickPreview: function () {
    $("a.preview").on('click', function () {
      let ref_obj = $("#" + $(this).data('ref'))
      let preview_content = ref_obj.val()
      if (preview_content.length == 0) {
        ref_obj.trigger('focus')
        return
      }

      var type = $(this).data('type')
      $.post("/topics/preview.text", { content: preview_content, type: type }, (data) => {
        ref_obj.hide()
        $("#preview").html(data).show()
        $("#preview").css('border', '1px dotted #ccc')
        $("#preview").css('background', 'lightyellow')
        $("#preview").css('padding', '10px')
        $("a.preview").addClass('current_label')
        $(".cancel_preview").removeClass('current_label')
      })
    })
  },
  cancelPreview: function () {
    $("a.cancel_preview").on('click', function () {
      var content_id = $(this).data('ref')
      var ref_obj = $("#" + content_id)
      $("#preview").hide()

      ref_obj.show()
      ref_obj.trigger('focus')
      $(this).addClass('current_label')
      $("a.preview").removeClass('current_label')
    })
  },
}

export default rabel;
