(function($) {
  $(function() {

    // if you want to use multiple crop util instances on one page
    // please rewrite this object for correct inheritance

    var crop = {
      api: null,
      dom: {},
      init: function(options) {

        var that = this;

        this.dom.$cropForm = options.$cropForm.clone();
        this.dom.$cropTarget = this.dom.$cropForm.find('#croptarget');
        this.dom.$shadow = this.dom.$cropForm.find('.shadow');
        this.dom.$cropContent = this.dom.$cropForm.find('.crop_content');
        this.dom.$cropbutton = this.dom.$cropForm.find('#cropbutton');
        this.dom.$x = this.dom.$cropContent.find('#x');
        this.dom.$y = this.dom.$cropContent.find('#y');
        this.dom.$w = this.dom.$cropContent.find('#w');
        this.dom.$h = this.dom.$cropContent.find('#h');

        if (this.api !== null) {
          this.api.destroy();
          jQuery('#cropbox').show();
          jQuery('.jcrop-holder').remove();
          this.api = null;
        }

        this.dom.$cropForm.on('submit', function() {
          $.ajax({
            dataType: 'json',
            type: 'PUT',
            data: {
              photo: {
                crop_x: that.dom.$x.val(),
                crop_y: that.dom.$y.val(),
                crop_w: that.dom.$w.val(),
                crop_h: that.dom.$h.val()
              }
            },
            url: Routes.crop_photo_path(options.photo_id)
          })
          .done(function(response, status, jqXHR) {
            that.hide();
            options.done(response, status, jqXHR);
          })
          .fail(function(jqXHR, textStatus, errorThrown) {
            options.fail(jqXHR, textStatus, errorThrown);
          });
          return false;
        });

        this.dom.$shadow.click(function() {
          that.hide();
        });
      },
      show: function(options){
        var that = this;

        this.dom.$cropTarget.attr('src', options.photo_url);

        this.dom.$cropTarget.Jcrop({
          aspectRatio: options.aspectRatio,
          onSelect:   _.bind(this.updateCoords, this),
          onChange: _.bind(this.updateCoords, this),
          boxWidth: options.boxWidth,
          boxHeight: options.boxHeight,
          trueSize: options.trueSize
        }, function () {
          that.api = this;
        });

        this.dom.$cropForm.prependTo('body');

        this.dom.$cropContent.width(options.boxWidth);

        this.dom.$cropbutton.hide();

        this.dom.$cropForm.removeClass('hidden');
        $('html').addClass('crop-lock');
      },
      hide: function(){
        this.dom.$cropForm.remove();
        this.dom.$cropForm.addClass('hidden');
        $('html').removeClass('crop-lock');
        $(document).off('mouseup');
      },
      updateCoords: function(coords){
        this.dom.$x.val(coords.x);
        this.dom.$y.val(coords.y);

        this.dom.$w.val(coords.w);
        this.dom.$h.val(coords.h);

        if(coords.w > 0 && coords.h > 0){
          this.dom.$cropbutton.show();
        }else{
          this.dom.$cropbutton.hide();
        }
      },
    };
    if(!window.utils) window.utils = {};
    window.utils.crop = crop;
  });
})(jQuery);
