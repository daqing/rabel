// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "@hotwired/stimulus"

import jQuery from "jquery"

window.jQuery = jQuery
window.$ = jQuery

import rabel from "./rabel"

rabel.onReady()

window.Rabel = rabel
