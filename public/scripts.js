$(function() {
  $('input:radio').click(function() {
      if ($(this).val() == 'true') {
        $('.administrative').show();
      } else if ($(this).val() == 'false') {
        $('.administrative').hide();
      }
  });
});
