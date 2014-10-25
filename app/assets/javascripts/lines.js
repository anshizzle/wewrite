/**
	LINES JS
	ALL THE COOL AJAX JAVASCRIPT WILL GO HERE

	TO-DO - HAVE LINES LOAD DYNAMICALLY
*/


$(document).ready(function() {

	//when a ne
	$(".select-next-line").click(function() {
		console.log($(this).text());
		console.log($(this).parent().data("id"));
		var line = $(this).text();
		var line_id = $(this).parent().data("id");

		var html = $("<span class='story-line' data-id='" + line_id + "'>" + line + "</span>").hide().fadeIn(2000);

		$("#story").append(html);


	});



});