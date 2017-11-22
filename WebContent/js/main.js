$(function() {
	function alignFooter() {
		var footer = $('#footer');
		footer.css('display', 'block');
		if($(window).height() <= screen.height - 90 ) {
			$('footer').addClass('navbar-fixed-bottom');
		}
	}
	
	$(function() {
		new WOW().init();
		alignFooter();
	});
	
	function encodeData(data) {
	    return Object.keys(data).map(function(key) {
	        return [key, data[key]].map(encodeURIComponent).join("=");
	    }).join("&");
	}
});


