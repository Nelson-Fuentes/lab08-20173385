$(document).ready(function(){
	$('#img').mouseover(function(){
		$('#img').attr('src', 'img/addUserBlanco.png');
		$('#add').css('background', '#f72929');
	});
	$('#img').mouseout(function(){
		$('#img').attr('src', 'img/addUserRojo.png');
		$('#add').css('background', '#f2f2f2');
	});
});