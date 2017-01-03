var ready;
ready = function() {
  setTimeout(function() {
   $('.ckeditor').each(function() {
    return CKEDITOR.replace($(this).attr('id'));
  });
   }, 3000);
};

$(document).ready(ready);
$(document).on('page:load', ready);