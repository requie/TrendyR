(function() {
  $(function() {
    var $form = $('#search-form');
    $form.find('[name="utf8"]').remove();

    $form.find('[name="q[created_at_gteq]"], [name="q[created_at_lteq]"]').datepicker({ dateFormat: 'dd/mm/yy' });

    $form.on('change', '[name="q[charge_id_cont]"], [name="q[created_at_gteq]"], [name="q[created_at_lteq]"]',
      function() {
        $form.submit();
      }
    );
  });
})(jQuery);
