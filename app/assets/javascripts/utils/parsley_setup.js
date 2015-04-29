(function($) {
  function parseDate($element) {
    // month, day, year
    return _.map(['(1i)', '(2i)', '(3i)'], function(date_selector) {
      return $element.find("[name*='" + date_selector + "']").val();
    });
  }

  function toggleDateErrors($element, toggle) {
    _.each(['(1i)', '(2i)', '(3i)'], function(date_selector) {
      $element.find("[name*='" + date_selector + "']").toggleClass('error-border', toggle);
    });
  }

  window.ParsleyConfig = {
    namespace: 'data-',
    errorsWrapper: '<div class="error-message"></div>',
    errorTemplate: '<span></span>',
    excluded: 'input[type=button], input[type=submit], input[type=reset], input[type=hidden], [group=date]',
    inputs: 'input, textarea, select',
    validators: {
      imagerequired: {
        fn: function(value, requirement) {
          var $el = $(requirement);
          $el.toggleClass('error-border', !value);
          return !!value;
        }
      },
      allConnectionsClosed: {
        fn: function(value, requirement) {
          return 0 === jQuery.active;
        },
        priority: 32
      },
      minOnePhoto: {
        fn: function(value, requirement) {
          return $('.editPicture:not(.hidden)').length > 0;
        }
      },
      existIfInputFilled: {
        fn: function(value, requirement) {
          if($(requirement).val()) {
            return Boolean(value);
          }
          return true
        }
      },
      anotherInputFilled: {
        fn: function(value, requirement) {
          return Boolean($(requirement).val());
        }
      },
      minLengthIfNotEmpty: {
        fn: function(value, requirement) {
          if(value) {
            return value.length >= requirement;
          } else {
            return true;
          }
        }
      },
      dateLower: {
        fn: function(value, requirement) {
          var $startElement = $(requirement.start),
            $endElement = $(requirement.end);
          var start = parseDate($startElement),
            end = parseDate($endElement);
          var someAreNotPicked = _.some(start.concat(end), _.isNaN);
          if (someAreNotPicked) {
            return true;
          }
          var startDate = new Date(start), endDate = new Date(end);
          if(startDate.getTime() < endDate.getTime()) {
            toggleDateErrors($startElement, false);
            toggleDateErrors($endElement, false);
            return true;
          } else {
            toggleDateErrors($startElement, true);
            toggleDateErrors($endElement, true);
            return false;
          }
        }
      }
    }
  };
})(jQuery);
