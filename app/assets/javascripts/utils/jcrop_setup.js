(function($) {
  $(function() {

    // if you want to use multiple crop util instances on one page
    // please rewrite this object for correct inheritance

    var crop = {
      api: null,
      dom: {},
      init: function(options) {

        var that = this;

        this.dom.$modal = $('#cropmodal');
        this.dom.$cropTarget = this.dom.$modal.find('#croptarget');
        this.dom.$cropContent = this.dom.$modal.find('.modal-footer');
        this.dom.$cropbutton = this.dom.$modal.find('#cropbutton');
        this.dom.$x = this.dom.$cropContent.find('#x');
        this.dom.$y = this.dom.$cropContent.find('#y');
        this.dom.$w = this.dom.$cropContent.find('#w');
        this.dom.$h = this.dom.$cropContent.find('#h');

        if (this.api !== null) {
          this.api.destroy();
          this.api = null;
        }

        this.dom.$cropbutton.off('click');
        this.dom.$cropbutton.on('click', function() {
          $.ajax({
            url: Routes.crop_photo_path(options.photo_id, options.preset),
            dataType: 'json',
            type: 'PUT',
            data: {
              photo: {
                crop_x: that.dom.$x.val(),
                crop_y: that.dom.$y.val(),
                crop_w: that.dom.$w.val(),
                crop_h: that.dom.$h.val()
              }
            }
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
      },
      show: function(options){
        var that = this;

        this.dom.$cropTarget.attr('src', options.photo_url);

        this.dom.$cropTarget.Jcrop({
          aspectRatio: options.aspectRatio,
          onSelect: _.bind(this.updateCoords, this),
          onChange: _.bind(this.updateCoords, this),
          boxWidth: options.boxWidth,
          boxHeight: options.boxHeight,
          trueSize: options.trueSize
        }, function () {
          that.api = this;
        });

        this.dom.$cropbutton.hide();
        this.dom.$modal.modal('show');
      },
      hide: function() {
        this.dom.$modal.modal('hide');
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
      }
    };

    window.utils.crop = crop;
  });
})(jQuery);
