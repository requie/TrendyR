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

var resizeFooter = function ($mainBlock) {
		var $footer 	= $('footer'),
			$header		= $('#nav'),
			$windows 	= window.innerHeight;
	if($mainBlock.height() + $footer.height() + $header.height() < $windows){
		$mainBlock.height($windows - $footer.height() + 'px');
	} 
}

// [ Height ]
$.fn.equivalent = function (){
	var $blocks = $(this),
		maxH    = $blocks.eq(0).height(); 			
	$blocks.each(function(){
		maxH = ( $(this).height() > maxH ) ? $(this).height() : maxH;				
	});
	$blocks.height(maxH); 
}

var progressBar = function(){
	for (var $count = 0; $count < 1; $count++){		
		setInterval(function(){
     		$('.progressBar').text($count++ + "%");		     		
     		if($count === 100){
				$count = 0;
			}
  		}, 100
		);
	}	
}

var backImage = function(){
		_src = $('.manadgmentFoto').find('.manageAvatar').attr('src');
	}

var bgImage = function($bg, $img){
	$(this).each(function(){
	var $this 	= $bg,
		_src 	= $this.find($img).attr('src');
		$this.attr('style','background-image:url('+_src+')');
		$this.find($img).remove();
	})
}

var timeConcert = function(){
	var $this 			= $(this),
		$concert 		= $('.concert.visible').attr('data-src'),
		$timeConcert 	= $('.timeConcert').find('span');
	$timeConcert.text($concert);
}

/*---------- [Tabs] ------------*/

var Tabs = function Tabs($box) {
    //var $tabsBlock = $tab.find('ul');
   // $tab.on('click', 'li:not(.active)', function() {
    $(document).on('click', ('.dateTabs li:not(.active)'), function() {
        var $this = $(this);            
        $this.addClass('active').siblings().removeClass('active')
            .parents('.container').find('.concert.visible').find('.bookMe').eq($this.index()).fadeIn(150).siblings('.concert.visible .bookMe').hide();
     
    })
}

CountGoods = {
	numericValidationString: /^[0-9]+$/
};
function ValidateNumeric(input){
	return CountGoods.numericValidationString.test(input);
}
$.fn.quantityInput = function(){
    $(this).each(function(){
        var $decrement = $(this).find('.decrementGoods'),
            $quantity = $(this).find('.goodsQuantity'),
            $incriment = $(this).find('.incrementGoods');

        $incriment.on('click', function () {
            if (ValidateNumeric($quantity.val())) {
                var number = parseInt($quantity.val());
                number--;
                if (number < 0) number = 0;
                $quantity.val(number);
            }
            else $quantity.val(0);

            return false;

        });
     	$decrement.on('click', function () {
            if (ValidateNumeric($quantity.val())) {
                var number = parseInt($quantity.val());
                number++;
                if (number < 0) number = 0;
                $quantity.val(number);
            }
            else $quantity.val(0);

            return false;
        });
    });
};
