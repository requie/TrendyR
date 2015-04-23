/* 
 *  Written for: Trendy Reggae
 *  Author: @IkantamCorp - @InessaKukushkina
 */
$(document).ready(function(){
	resizeFooter($('.login'));
	resizeFooter($('.strPage'));
	$('.column').equivalent();

  $('.custom-form').on('click', '.cb-checkbox', function(){
    $(this).closest('.gallery').toggleClass('settingVis');
  }).checkBo();

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

	$(".gallery-image").fancybox({
		"padding" : 0,
		"imageScale" : false, 
		"zoomOpacity" : false,
		"zoomSpeedIn" : 1000,	
		"zoomSpeedOut" : 1000,	
		"zoomSpeedChange" : 1000, 
		"frameWidth" : 700,	 
		"frameHeight" : 600, 
		"overlayShow" : true, 
		"overlayOpacity" : 0.9,	
		"hideOnContentClick" :false,
		"centerOnScroll" : false,
		helpers : {
			media : {}
		}
	});

	$('.slider').slick({
    centerMode: true,
		variableWidth: true,
		infinite:true
	});
 	$('.seeMore').jTruncate({  
        length: 250,  
        minTrail: 0,  
        moreText: "see more",  
        lessText: "hide",  
        ellipsisText: " ...",  
        moreAni: "fast",  
        lessAni: 500
    });  
	

	$('.faqQuestion').on('click',function(){	
        $(this).find('p').slideToggle(100);    
        
        if($(this).find('i').hasClass('icon-plus')){
            $(this).find('i').removeClass('icon-plus').toggleClass('icon-minus');
        }
        else{
            $(this).find('i').removeClass('icon-minus').toggleClass('icon-plus');;                       
        }					
	});	
	
	$('.manadgMenu').find('ul li a').on('click',function(){
		if($(this).hasClass('menuActive')){
			$(this).removeClass('menuActive');
		}
		else{
			$(this).toggleClass('menuActive');
		}
	})	

	$(window).scroll(function(){
		if($(this).scrollTop()>100) $('a#moveUp').fadeIn();
		else $('a#moveUp').fadeOut(400);
	});
	$('a#moveUp').on('click',function(){
		$('body,html').animate({scrollTop: 0}, 450);
		return false;
	});	

	// [ Custom file input ]
	if(document.querySelector('.fileSelect')){
	    document.querySelector('.fileSelect').addEventListener('click', function(e) {
          e.preventDefault();
	        var fileInput = document.querySelector('.uploadbtn');
	        fileInput.click();
	    }, false);
	}

	if(document.querySelector('.newSelect')){
	    document.querySelector('.newSelect').addEventListener('click', function(e) {
          e.preventDefault();
	        var fileInput = document.querySelector('.uploadfile');
	        fileInput.click();
	    }, false);
	}

	Tabs($('.dateTabs'), ('.bookMe'));

	timeConcert();

	$('.icon-left').on('click', function(){	
		var $concertVis = 	$('.concert.visible').prev();
		if($concertVis.is('.concert')){
			$concertVis.addClass('visible');
			$concertVis.next().removeClass('visible');
			timeConcert();
		}
	})

	tinymce.init({
    selector: '.editor',
    menubar: false,
  });

	$('.icon-right').on('click', function(){	
		var $concertVis = 	$('.concert.visible').next();
		if($concertVis.is('.concert')){
			$concertVis.addClass('visible');
			$concertVis.prev().removeClass('visible');
			timeConcert();
		}
	})
	$('.crop_content').width($('.crop_picture').width());	
	$('.jcrop-holder').find('div').first().addClass('jcrop-move')//;.css('max-width','400px');

})//close Ready

$(window).resize(function () {
	resizeFooter($('.login'));
	resizeFooter($('.strPage'));
	
	$('.crop_content').width($('.crop_picture').width());
})