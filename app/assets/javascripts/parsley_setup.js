(function($) {
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
            $startElement = $(requirement.start);
            $endElement = $(requirement.end);
            var startDay = $startElement.find("[name*='(3i)']").val();
              startMonth = $startElement.find("[name*='(2i)']").val();
              startYear = $startElement.find("[name*='(1i)']").val();
              endDay = $endElement.find("[name*='(3i)']").val();
              endMonth = $endElement.find("[name*='(2i)']").val();
              endYear = $endElement.find("[name*='(1i)']").val();
            var someAreNotPicked = _.some([startDay, startMonth, startYear, endDay, endMonth, endYear], _.isNaN);

            var startDate = new Date(startYear, startMonth, startDay);
                endDate = new Date(endYear, endMonth, endDay);

            if (someAreNotPicked) {
              return true;
            }

            if (startDate.getTime() < endDate.getTime()) {
              return true;
            }
            else {
              return false;
            }

          }
        }
      }
    };
})(jQuery);