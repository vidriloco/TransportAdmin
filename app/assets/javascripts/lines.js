var replaceSigning = function() {
	if($('.sign').text() == '+') {
		$('.sign').text('-');
	} else {
		$('.sign').text('+');
	}
}

$(document).ready(function() {
	if($.isDefinedInDom('.way-form-toggle')) {
		$('.way-form-toggle').click(function() {
			$('.new-way-form').toggle();
			replaceSigning();
		});
	}
});