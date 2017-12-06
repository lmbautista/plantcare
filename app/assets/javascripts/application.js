//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require jquery
//= require bootstrap-sprockets
//= require jasny/jasny-bootstrap.min
//= require growl/jquery.growl
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.es.js

$(document).ready(function(){
  setTimeout(function(){
    $('.datepicker').datepicker({
                      locale: gon.locale
                  });
  }, 1000)
})
