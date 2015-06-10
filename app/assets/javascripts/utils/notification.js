(function() {
  $(function() {
    var Notification = function() {
      this._init();
    };

    Notification.prototype = {
      _init: function() {
        var self = this,
          templateStr = '<div class="<%= msg.class %>"><p><%= msg.text %></p><i class="icon-close-block"></i></div>';
        self.template = _.template(templateStr, { variable: 'msg' });
        self.$parent = $('.notification_block');
        self.$parent.on('click', 'i.icon-close-block', function(e) {
          e.preventDefault();
          self.hide();
        });
      },
      show: function(message) {
        this.$parent.html(this.template(message));
      },
      hide: function() {
        var $parent = this.$parent;
        $parent.fadeOut(500, function() {
          $parent.html('');
        });
      }
    };

    window.utils.notification = new Notification();
  });
})(jQuery);
