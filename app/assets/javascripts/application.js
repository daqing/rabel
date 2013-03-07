//= require jquery
//= require jquery_ujs
//= require jquery.ui.sortable
//= require jquery.ui.datepicker
//= require jquery.ui.datepicker-zh-CN
//= require twitter/bootstrap
//= require jquery.ui.effect-highlight
//= require jquery_elastic
//= require jquery.facebox
//= require jquery_at_caret
//= require jquery_smooth_scroll
//= require rabel

$(document).ready(function() {
  if ($('#topic-hit').attr("data-id")){
    $.ajax({
        type: "POST",
        url: "/topics/hit",
        data: { id: $('#topic-hit').attr("data-id"), authenticity_token: $('meta[name=csrf-token]').attr('content') }
    });
  }
});
