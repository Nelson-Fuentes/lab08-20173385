$(document).ready(function () {
	$('input').keyup(function (){
		if ($(this).val()==' ')
			$(this).val('');
	});
});
