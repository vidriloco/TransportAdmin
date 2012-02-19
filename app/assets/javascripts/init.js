var delayMessageTime = 3500;
var mapWrap = null;

$(document).ready(function() {
	if(!$('#notifications').is(':empty')) {
		$('#notifications').fadeIn('slow').delay(delayMessageTime).fadeOut('slow');
	}
	
	if(!$('#alerts').is(':empty')) {
		$('#alerts').fadeIn('slow').delay(delayMessageTime).fadeOut('slow');
	}
	
	if($.isDefined('.color-h')) {
		$('.colorable').css('background-color', $('.color-h').text());
	}

	var mapDefaultOpts = {
		center: new google.maps.LatLng(parseFloat(19.434780), parseFloat(-99.133072)),
		zoom: 13,
		mapTypeId: google.maps.MapTypeId.ROADMAP,
		streetViewControl: true,
		mapTypeControl: false,
		navigationControl: false,
		navigationControlOptions: {
			position: google.maps.ControlPosition.TOP_RIGHT
		},
		zoomControlOptions: { style: google.maps.ZoomControlStyle.SMALL }
	};

	// domPoint will be appended with "_lat" and "_lon" 
	var mapInteractionOpts = {
		"domEditable" : ".is-editable",
		"domAddress" : "p.address",
		"pointsMode" : ".displays-points",
		"domPoint" : "#coordinates"
	}
	
	if($.isDefined("#map")) {
		mapWrap = new MapWrapper(new google.maps.Map(document.getElementById("map"), mapDefaultOpts), mapInteractionOpts);
	}
});