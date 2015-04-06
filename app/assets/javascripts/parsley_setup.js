(function($) {
  function parseDate($element) {
    // month, day, year
    return _.map(['(1i)', '(2i)', '(3i)'], function(date_selector) {
      return $element.find("[name*='" + date_selector + "']").val();
    });
  }

  window.ParsleyConfig = {
    namespace: 'data-',
    errorsWrapper: '<div class="error-message"></div>',
    errorTemplate: '<span></span>',
    excluded: 'input[type=button], input[type=submit], input[type=reset], input[type=hidden]',
    inputs: 'input, textarea, select',
    validators: {
      allConnectionsClosed: {
        fn: function (value, requirement) {
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
          if(value) return value.length >= requirement;
          else return true;
        }
      },
      dateLower: {
        fn: function(value, requirement) {
          var $startElement = $(requirement.start);
            $endElement = $(requirement.end);
          var start = parseDate($startElement),
            end = parseDate($endElement);
          var someAreNotPicked = _.some(start.concat(end), _.isNaN);
          if (someAreNotPicked) {
            return true;
          }
          var startDate = new Date(start), endDate = new Date(end);
          return startDate.getTime() < endDate.getTime();
        }
      }
    }
  };
})(jQuery);
