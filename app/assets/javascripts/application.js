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

function uploader_control($input, $preview){
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function(e) {
        $preview.css('background-image', 'url("' + e.target.result + '")');
      };

      reader.readAsDataURL(input.files[0]);
    }
  }
  $input.change(function() {
    readURL(this);
  });
}

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
