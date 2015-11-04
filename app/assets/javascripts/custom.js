$(document).on('click', '[data-submit-form]', function(e) {
  e.preventDefault();
  $(this).closest('form').submit()
}
