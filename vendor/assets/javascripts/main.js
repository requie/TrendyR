/* 
 *  Written for: Trendy Reggae
 *  Author: @IkantamCorp - @ElmahdiMahmoud
 */
// [ Height ]
$.fn.equivalent = function (){
  var $blocks = $(this),
    maxH    = $blocks.eq(0).height();
  $blocks.each(function(){
    maxH = ( $(this).height() > maxH ) ? $(this).height() : maxH;
  });
  $blocks.height(maxH);
}
var fitHeight = function () {
  $('.fit-height').css('height', window.innerHeight);
};
(function($) {
  $(document).ready(function() {

// [ Height ]
    $('.column').equivalent();

// [ Audio player ]
    $(function () {
      var audio = document.createElement("audio");
      audio.toHHMMSS = function (num) {
        var sec_num = parseInt(num, 10);
        var hours = Math.floor(sec_num / 3600);
        var minutes = Math.floor((sec_num - (hours * 3600)) / 60);
        var seconds = sec_num - (hours * 3600) - (minutes * 60);

        //if (hours   < 10) {hours   = "0"+hours;}
        //if (minutes < 10) {minutes = "0"+minutes;}
        if (seconds < 10) {
          seconds = "0" + seconds;
        }
        var time = minutes + ':' + seconds;
        console.log(time);
        return time;
      }

      audio.setTrack = function ($track) {
        this.blockTrack = $track;
        audio.src = this.blockTrack.attr('data-src');
        audio.play();

        audio.addEventListener("timeupdate", function () {
          //this.blockTrack.find('.track-duration').html(this.toHHMMSS(this.currentTime) + ' - ' + this.toHHMMSS(this.duration));
          this.blockTrack.find('.track-duration').html(this.toHHMMSS(this.currentTime));
        });
      };

      $('.track-list .track').each(function () {
        var $this = $(this),
          control = $this.find('.track-control');
        control.on('click', '.btn-control', function () {
          var isActive = $(this).hasClass('is-active');
          if(!isActive) {
            audio.setTrack($this);
          } else {
            audio.pause();
          }
          $('.btn-control').removeClass('is-active');
          if(!isActive) $(this).addClass('is-active');
        });
      });
    });

// [ Step to ]
    $('.jump-to').on('click', function (e) {
      e.preventDefault();
      $('html,body', document).animate({
        scrollTop: $(this.hash).offset().top
      }, 800);
      return false;
    });


    window.onscroll = function () {
      effects();
    }

    effects();

    /* 158 = top bar + main header height */
    var headerHeight = 60;



    function effects() {
      $('.animate-it').each(function() {
        var $_this = $(this);

        if($(document).scrollTop() > $_this.offset().top - headerHeight - window.innerHeight) {
          $_this.addClass($_this.attr('data-animate'));
        }
        else {
          $_this.removeClass($_this.attr('data-animate'));
        }
      });
    };


    fitHeight();

    $(window).resize(function () {
      fitHeight();
    });  ;(function ($, window, document, undefined) {
      $.fn.statesCarousel = function (options) {
        return this.each(function () {
          var $this = $(this),
            $ul = $this.find('.states-slides');

          var wOver = wUl = maxL = null,

            settings = $.extend({
              step    : null,
              speed   : 300,
              autoPlay: false,
              autoSpeed: 5000
            }, options),

            _step;

          if(settings.step === null) {
            $(window).resize(function(){
              var $li = $ul.find('li').first();
              _step = $li.outerWidth();
            });
            $(window).resize();
          } else {
            _step = settings.step;
          }

          init();

          function reset() {
            $ul.css('left', '0');
            wUl   = 0;
            wOver = $ul.parent().width();
            var ww    = $(window).width(), liW;

            if(ww > 1200){ liW = 300; }
            else if (1200 >= ww && ww > 1024) { liW = wOver / 3; }
            else if (1024 >= ww && ww > 992) { liW = wOver / 2; }

            else { liW = wOver; }
            $this.find('li').width(liW - 40);

            if(settings.step === null) {
              _step = $this.find('li').outerWidth();
            }
            $this.find('li').each(function () {
              wUl += $(this).outerWidth();
            });
            maxL = wUl - wOver;
            $ul.width(wUl);
          }

          function init() { reset(); }
          $(window).on('resize', function () {
            reset();
          });

          function SlideDir(dir) {
            this.dir = dir;
            if(dir == 'left') {
              var left = parseInt($ul.css('left')) - _step;
              if (-maxL > left) left = -maxL;
            } else {
              var left = parseInt($ul.css('left')) + _step;
              if (left > 0) left = 0;
            }
            $ul.stop().animate({
              left: left
            }, settings.speed, 'linear');
          }

          if(settings.autoPlay === true) {
            setInterval(function() {
              var leftDir  = new SlideDir('left');
            }, settings.autoSpeed);
          }
        });
      }
    })(jQuery, window, document);

    $('.tr-states').statesCarousel({
      autoPlay: true
    });  var
      current     = 0,
      flagActive  = true,
      trSlider    = $(".tr-slider"),
      sliderLayer = $('.tr-slide'),
      firstLayer  = sliderLayer.first(),
      totalLayers = sliderLayer.length;

    firstLayer.css('display','block').addClass('is-active');
    sliderBullets = trSlider.append('<div class="slider-bullets"></div>');

    if(totalLayers - 1) {
      for(i = 0; i < totalLayers; i++){
        $('<span></span>').appendTo('.slider-bullets');
      }
    }

    $('.slider-bullets').css('margin-top', - $('.slider-bullets').height() / 2);

    var bullet = $('.slider-bullets span');
    bullet.first().addClass('is-active');


    $('[data-src]').each(function(){
      $(this).css('background-image', 'url(' + $(this).data('src') + ')');
    });

    $('.slider-bullets span').each(function(){
      var _$this = $(this),
        _index = _$this.index();


      _$this.on('click', function(){
        if(flagActive){
          flagActive = false;
          $("span.is-active").removeClass("is-active");
          $(this).addClass("is-active");
          sliderLayer.hide().removeClass('is-active');
          sliderLayer.addClass('is-active');
          sliderLayer.eq(_index).fadeIn('slow');
          setTimeout(function(){
            flagActive = true;
          }, 600);
        }
        return false;
      });
    });

// [ Move up ]
    $(function(){
      $(window).scroll(function(){
        if($(this).scrollTop()>100) $('a#moveUp').fadeIn();
        else $('a#moveUp').fadeOut(400);
      });
      $('a#moveUp').click(function(){
        $('body,html').animate({scrollTop: 0}, 450);
        return false;
      });
    });

    // [ Close ]
    $('.icon-close').click(function(){
      $('.sorting').slideToggle(150);
    });
  }); // end doc ready
})(jQuery);

// [ Custom file input ]

document.querySelector('.fileSelect').addEventListener('click', function(e) {
  var fileInput = document.querySelector('.uploadbtn');
  fileInput.click();
}, false);
document.querySelector('.newSelect').addEventListener('click', function(e) {
  var fileInput = document.querySelector('.uploadfile');
  fileInput.click();
}, false);