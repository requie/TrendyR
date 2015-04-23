$(function() {
  /*audiojs.events.ready(function() {
   audiojs.createAll();
   });*/
  // Setup the player to autoplay the next track
  $('body').on('click', '.audioTrack', function(e) {
    e.preventDefault();
    $('table').find('.audiojs').removeClass('playing');
    $('audio').remove();
    $("div[id^='audiojs_']").remove();
    $('.audiojs').show();
    $('table').find('td').removeClass('player');
    $(this).closest('td').toggleClass('player');
    $('<audio preload></audio>').prependTo($(this).closest('td'));
    var a = audiojs.createAll({
      trackEnded: function () {
        var next = $('.audioTrack.playing').closest('tr').next('tr').find('.audioTrack');
        if (!next.length) {
          next = $('.audioTrack').first();
          console.log('abab');
        } else {
          $('.audioTrack').removeClass('playing');
          next.addClass('playing');
        }
        audio.load($('a', next).attr('data-src'));
        audio.play();
      }
    });
    var audio = a[0],
      $trackLoad = $(this).closest('td').find('a').attr('data-src'),
      first = $('.audioTrack a').attr('data-src');
    $('.audioTrack').first().addClass('playing');
    audio.load(first);

    if ($(this).hasClass('playing')) {
      audio.playPause();
    } else {
      audio.pause();
      $('.audioTrack').removeClass('playing');
      $(this).addClass('playing');
      audio.load($trackLoad);
      audio.play();
    }
    console.log($("div[id^='audiojs_']"));
  });
  //Keyboard shortcuts
  $(document).on('keydown', ':not(input)', function (e) {
    var unicode = e.charCode ? e.charCode : e.keyCode;
    // right arrow
    if (unicode == 39) {
      var next = $('.audioTrack.playing').next();
      if (!next.length) next = $('.audioTrack').first();
      next.click();
      // back arrow
    } else if (unicode == 37) {
      var prev = $('.audioTrack.playing').prev();
      if (!prev.length) prev = $('.audioTrack').last();
      prev.click();
      // spacebar
    } else if (unicode == 32) {
      audio.playPause();
    }
  })
});
