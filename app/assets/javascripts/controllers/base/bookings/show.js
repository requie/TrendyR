//= require utils/parsley_setup
//= require parsley
//= require utils/parsley-init

(function($) {
  $(function() {
    var $form = $('.parsley-form'),
      $error = $form.find('.error-msg'),
      $startedAtDate = $('.inputDate[name="booking[started_at]"]');


    $form.parsley().subscribe('parsley:form:validate', function(formInstance) {
      if (formInstance.isValid(null, true)) {
        $error.addClass('hidden');
        return;
      }
      formInstance.submitEvent.preventDefault();
      $error.removeClass('hidden');
    });

    $('.inputDate').datepicker({ dateFormat: 'dd-mm-yy' });

    $('body')
      .on('click', '[data-select-date]', function(e) {
        e.preventDefault();
        var $this = $(this),
          $tr = $this.parents('tr');
        toggleCalendarDate($this.parents('table').find('tr.activated'), true);
        toggleCalendarDate($tr, false);
        $startedAtDate.datepicker('setDate', new Date($tr.data('date')));
      })
      .on('click', '[data-cancel-date]', function(e) {
        e.preventDefault();
        var $tr = $(this).parents('tr');
        toggleCalendarDate($tr, true);
        $startedAtDate.datepicker('setDate', null);
      });

    function toggleCalendarDate(element, toggle) {
      var $element = $(element);
      if (!$element.length) {
        return;
      }
      $element.toggleClass('activated', !toggle);
      $element.children().remove('.switch');
      var tmpl = toggle ? template.available() : template.selected();
      $element.append(tmpl);
    }
  });

  var template = {
    available: function() {
      return $([
        '<td class="switch" data-th="Name gig">',
        '<a class="link" href="javascript: void(0)">',
        '<span>Available date</span>',
        '</a></td>',
        '<td class="switch" data-th="Where">',
        '<button class="btn btn-primary pull-sm-right" data-select-date="">Select</button>',
        '</a></td>'
      ].join(''));
    },
    selected: function() {
      return $([
        '<td class="switch" data-th="Name gig">',
        '<p><i class="fa fa-check-circle color_green"> Selected</i></p>',
        '</td>',
        '<td class="switch" data-th="Where">',
        '<a class="link pull-sm-right" href="javascript: void(0)" data-cancel-date=""> Cancel</a>',
        '</td>'
      ].join(''))
    }
  };
})(jQuery);
