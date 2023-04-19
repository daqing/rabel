// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "@hotwired/stimulus"
import jQuery from "jquery"
// import "bootstrap"
import 'bootstrap/dist/js/bootstrap'

window.jQuery = jQuery
window.$ = jQuery

//= require jquery-ui/widgets/sortable
//= require jquery-ui/widgets/datepicker
//= require jquery-ui/i18n/datepicker-zh-CN
//= require jquery-ui/effects/effect-highlight
//= require jquery_elastic
//= require jquery.facebox
//= require jquery_at_caret
//= require jquery_smooth_scroll
//= require rabel
