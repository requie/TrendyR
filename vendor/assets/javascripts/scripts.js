$.fn.correctLines = function( maxLine, moreText ) {
  return this.each(function( index, self ) {
    var temp, classes, i, lineHeight;
    maxLine = ( temp = /^(?:.*\s)?fixline_([\d]+)(?:\s.*)?$/.exec( self.className ) ) && temp[1] || maxLine || 3;
    moreText = moreText || '...<br />';
    var od = $( self ).css( "display" );
    var clone = $( self ).css( "display", "block" ).clone( true ).
      css( {"height": "auto", "position": "absolute", "width": self.offsetWidth + "px" } ).html("");
    $( self ).css( "display", od ).after( clone );

    var height = 0,
      width = self.offsetWidth,
      lines = 0,
      lastHeight = 0,
      startWord = 0,
      endWord = -1,
      txt = self.innerHTML,
      part = [];
    while( /(<.*)\s(.*>)/g.exec( txt ) ) {
      txt = txt.replace(/(<.*)\s(.*>)/g, '$1&jftF767Tgjk56&$2');
    }
    txt = txt.split(' ');

    for( i = 0; i < txt.length; i++ ) {
      txt[i] = txt[i].replace(/&jftF767Tgjk56&/g, ' ');
      clone[0].innerHTML += txt[ i ] + ' ';
      if ( clone[0].clientHeight > lastHeight ) {
        height = lastHeight;
        startWord = endWord + 1;
        endWord = i - 1;
        lastHeight = clone[0].offsetHeight;
        if ( ++lines > maxLine ) {
          break;
        }
      }
    }
    if ( lines > maxLine ) {
      $( self ).css({height: height + "px", overflowY: 'hidden'});
      part = txt.slice( startWord, endWord + 1 );
      height = clone.html( part.join(' ') )[0].offsetHeight;
      for( i = part.length - 1; i >= 0; i-- ) {

        clone.html( part.join(' ') + moreText );

        if ( clone[0].offsetHeight > height ) {
          part.splice( i, 1 );
          endWord--;
        } else {
          break;
        }
      }
      txt[ endWord ] += moreText;

      self.innerHTML = txt.join(" ");
    } else {
      $( self ).css({height: "auto"});
    }
    clone.remove();
  });
}
var hideBlock = function hideBlock ($mainBlock, $hideBlock){
  $mainBlock.click(function(e) {
    if ($hideBlock.css('display') != 'block') {
      $hideBlock.show();
      var firstClick = true;
      $(document).bind('click.myEvent', function(e) {
        if (!firstClick && $(e.target).closest($hideBlock).length == 0) {
          $hideBlock.hide();
          $(document).unbind('click.myEvent');
        }
        firstClick = false;
      });
    }
    e.preventDefault();
  })
}
$(document).ready(function(){
  var fooHeight = $('#footer').height(),
    docHeight = $(document).height(),
    navHeight = $('#nav').height();
  loginBlockHeight = docHeight - navHeight + 'px';
  //pgHeight = docHeight /*navHeight  fooHeight -*/+ 45 +'px'
  //$('.pg').height(pgHeight);
  page = docHeight - navHeight - fooHeight + 'px';
  //$('.strPage').height(page);
  loginHeight = $('.login').height();
  if (loginBlockHeight > loginHeight){
    $('.login-block').height(loginHeight);
  }
  else{
    $('.login-block').height(loginBlockHeight);
  }
  $('.custom-form').checkBo();

  $('.cb-checkbox').click(function(){
    $(this).closest('.gallery').toggleClass('settingVis');
  });

  $(".nav-page").tinyNav();

  $("#foo-menu").tinyNav();

  $("td .nameMessage p").correctLines( 1, '&nbsp;...' );
  $(".inboxMess p").correctLines( 1, '&nbsp;...' );

  hideBlock ($('.mob-menu'), $('.mobile-menu'));
  hideBlock ($('a .icon-message'), $('.inboxMess'));
  hideBlock ($('a .icon-ring'), $('.inboxRing'));
  hideBlock ($('a.nameUser'), $('.userInform'));

  $('tr.message .icon-delete').click(function(){
    $(this).closest('tr.message').remove();
  })
  $('tr.newMessage .icon-delete').click(function(){
    $(this).closest('tr.newMessage').remove();
  })

  $('.icon-close-block').click(function(){
    $(this).parent().slideToggle(100);
  })
  $('.error-message').closest('.form-group').find('input, textarea').attr('style', 'border:1px solid red !important');

  $('.inputDate').datepicker({});

  $('.faqQuestion').click(function(){
    $(this).find('p').slideToggle(100);

    if($(this).find('i').hasClass('icon-plus')){
      $(this).find('i').removeClass('icon-plus').toggleClass('icon-minus');
    }
    else{
      $(this).find('i').removeClass('icon-minus').toggleClass('icon-plus');;
    }
  });
  $('.manadgMenu').find('ul li a').click(function(){
    if($(this).hasClass('menuActive')){
      $(this).removeClass('menuActive');
    }
    else{
      $(this).toggleClass('menuActive');
    }
  })
  //$('<span class="arrow">&nbsp;</span>').prependTo($('.ui-datepicker'));
})
