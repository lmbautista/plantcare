//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require jquery
//= require bootstrap-sprockets
//= require growl/jquery.growl
//= require moment
//= require bootstrap-datetimepicker
//= require jquery-fileupload

function uploaderControl($previewInput, $preview, $input) {
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $preview.css('background-image', 'url("' + e.target.result + '")');
      };

      reader.readAsDataURL(input.files[0]);
    }
  }
  // trigger hidden input field
  $previewInput.on('click', function () { $input.trigger('click'); })
  // update hidden input field image
  $input.change(function () {
    readURL(this);
  });
}

function datepickerControl() {
  $('.datepicker').attr("autocomplete", "off");

  $('.datepicker').datetimepicker({
    locale: gon.locale,
    format: 'DD/MM/YYYY HH:mm'
  }).on('changeDate', function (e) {
    var _d = e.date.getDate(),
      d = _d > 9 ? _d : '0' + _d,
      _m = e.date.getMonth(),
      m = _m > 9 ? _m : '0' + _m,
      formatted = e.date.getFullYear() + '-' + m + '-' + d;
    $('[name=date]').val(formatted);
  });
}

function linkControl() {
  $(document).ajaxStart(function () {
    $('.loading-overlay').removeClass('hidden');
  }).ajaxStop(function () {
    $('.loading-overlay').addClass('hidden');
  });

  $('form[remote!="true"]').submit(function () {
    $('.loading-overlay').removeClass('hidden');
  });

  $('a:not([href^="#"]), button:not([data-dismiss], [data-toggle]), input[type="submit"]').click(function (e) {
    if (!e.shiftKey) { $('.loading-overlay').removeClass('hidden'); }
  });
}

function bindTooltips(){ $('[data-toggle="tooltip"]').tooltip(); }

$(document).ready(function () {
  bindTooltips();
  datepickerControl();
  linkControl();
})
