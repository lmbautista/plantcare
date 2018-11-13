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
//= require jquery-fileupload

$(document).ready(function(){
  $('.datepicker').datepicker({
    locale: gon.locale
  }).on('changeDate', function(e){
        var _d = e.date.getDate(),
            d = _d > 9 ? _d : '0'+_d,
            _m = e.date.getMonth(),
            m = _m > 9 ? _m : '0'+_m,
            formatted = e.date.getFullYear() + '-' + m + '-' + d;
        $('[name=date]').val(formatted);
    });
})
