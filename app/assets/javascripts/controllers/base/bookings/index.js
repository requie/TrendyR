(function($) {
  $(function() {
    var bookings = $("#bookings_table"),
      my_bookings = $("#my_bookings_table");

    $("#my_bookings_table").hide();
    $('body')
      .on('click', '.apply-booking', function(e) {
        e.preventDefault();
        var $this = $(this);
        $.ajax({
          url: $this.data('url'),
          method: 'PUT',
          success: function() {
            $this.parent().html($('<p class="p-t7">Applied</p>'));
          }
        });
      })
      .on('click', '.cancel-booking', function(e) {
        e.preventDefault();
        var $this = $(this);
        $.ajax({
          url: $this.attr('href'),
          method: 'PUT',
          success: function() {
            $this.parent().html($('<p class="p-t7">Canceled</p>'));
          }
        });
      });

    $("#gig_invintations").click(function() {
      my_bookings.hide();
      bookings.show();
      $("#gig_invintations").parent('li').removeClass("title_profile-list_gray").addClass("title_profile-list_black");
      $("#my_gig_invintations").parent('li').removeClass("title_profile-list_black").addClass("title_profile-list_gray");
    });

    $("#my_gig_invintations").click(function() {
      bookings.hide();
      my_bookings.show();
      $("#my_gig_invintations").parent('li').removeClass("title_profile-list_gray").addClass("title_profile-list_black");
      $("#gig_invintations").parent('li').removeClass("title_profile-list_black").addClass("title_profile-list_gray");
    });



  });
})(jQuery);
