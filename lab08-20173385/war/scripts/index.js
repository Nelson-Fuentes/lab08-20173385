$(document).ready(function(){
	$.get( "/users", function( data ) {
		setTimeout(function(){
			$('body').html(data);
			$('body').css('background', '#f2f2f2');
		},4000);
		//   $('#content').html(data);
	});

});