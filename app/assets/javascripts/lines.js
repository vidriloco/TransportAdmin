var replaceSigning = function(domElement) {
	if($(domElement).text() == '+') {
		$(domElement).text('-');
	} else {
		$(domElement).text('+');
	}
}

$(document).ready(function() {
	if($.isDefined('.way-form-toggle')) {
		$('.way-form-toggle').click(function() {
			$('.new-way-form').toggle();
			replaceSigning($(this).siblings()[0]);
		});
	}
	
	if($.isDefined('.extended-form-toggle')) {
		$('.extended-form-toggle').click(function() {
			$('.extended-form').toggle();
		});
	}
});