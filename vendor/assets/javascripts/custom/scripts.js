/* 
 *  Written for: Trendy Reggae
 *  Author: @IkantamCorp - @InessaKukushkina
 */
$(document).ready(function(){
	$('.column').equivalent();

	$('.custom-form').checkBo();

	$('.cb-checkbox').on('click', function(){
		$(this).closest('.gallery').toggleClass('settingVis');
	});				

	$(".nav-page").tinyNav();

	$('.goods').quantityInput();

	$("#foo-menu").tinyNav();
	
	//$("td .nameMessage p").correctLines( 1, '&nbsp;...' );		
	//$(".inboxMess p").correctLines( 1, '&nbsp;...' );

	$('tr.message .icon-delete').on('click', function(){
		$(this).closest('tr.message').remove();			
	})
	$('tr.newMessage .icon-delete').on('click', function(){			
		$(this).closest('tr.newMessage').remove();
	})

	$('#cropImage').modal();
	
	$('.icon-close-block').on('click', function(){
		$(this).parent().slideToggle(100);   
	})

//	$('.error-message').closest('.form-group').find('input').attr('style', 'border:1px solid red !important');
//	$('.error-message').closest('.form-group').find('textarea').attr('style', 'border:1px solid red !important');
//	$('.error-message').closest('.form-group').find('.well').attr('style', 'border:1px solid red !important');
//$('.error-message').closest('.form-group').find('.mce-tinymce').attr('style', 'border:1px solid red !important');
	
//	$('.inputDate').datepicker({});

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

    if ($(this).find('i').hasClass('icon-plus')) {
      $(this).find('i').removeClass('icon-plus').toggleClass('icon-minus');
    } else {
      $(this).find('i').removeClass('icon-minus').toggleClass('icon-plus');
    }
	});	
	
	$('.manadgMenu').find('ul li a').on('click',function(){
		if($(this).hasClass('menuActive')){
			$(this).removeClass('menuActive');
		}
		else{
			$(this).toggleClass('menuActive');
		}
	});

	$('.addMore').on('click', function(e){
		e.preventDefault();
		$(this).prev().clone(true).insertBefore($(this));
	});

	// [ Custom file input ]
	if(document.querySelector('.fileSelect')){
	    document.querySelector('.fileSelect').addEventListener('click', function() {
	        var fileInput = document.querySelector('.uploadbtn');
	        fileInput.click();
	    }, false);
	}

	if(document.querySelector('.newSelect')){
	    document.querySelector('.newSelect').addEventListener('click', function() {
	        var fileInput = document.querySelector('.uploadfile');
	        fileInput.click();
	    }, false);
	}

	Tabs($('.dateTabs'), ('.bookMe'));
//
//	bgImage($('.manadgmentFoto'), ('.manageAvatar'));
//	bgImage($('.create-event'), ('.create-event_avatar'));
	timeConcert();

	$('.icon-left').on('click', function(){	
		var $concertVis = 	$('.concert.visible').prev();
		if($concertVis.is('.concert')){
			$concertVis.addClass('visible');
			$concertVis.next().removeClass('visible');
			timeConcert();
		}
	});

	$('.icon-right').on('click', function(){
    var $concertVis = $('.concert.visible').next();
    if ($concertVis.is('.concert')) {
      $concertVis.addClass('visible');
      $concertVis.prev().removeClass('visible');
      timeConcert();
    }
	})
});
