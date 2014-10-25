/**
	LINES JS
	ALL THE COOL AJAX JAVASCRIPT WILL GO HERE

	TO-DO - HAVE LINES LOAD DYNAMICALLY
*/


$(document).ready(function() {

	//when a ne
	setUpNextLines();


});

function setUpNextLines() {
	$(".select-next-line").click(function() {
		console.log($(this).text());
		console.log($(this).parent().data("id"));
		var line = $(this).text();
		var line_id = $(this).parent().data("id");

		var html = $("<span class='story-line' data-id='" + line_id + "'>" + line + " </span>").hide().fadeIn(500);

		$("#story").append(html);


		var host = window.location.hostname;
		var url = "/lines/" + line_id + "/select_next";
		$.getJSON(url, function(data) {

			//if there are next lines, then replace the next-lines ul
			console.log(data);
			html = "";

			for(var i=0;i < data.length; i++) {
				console.log(data[i]);
				var text = data[i].text;
				var new_id = data[i].id;
				html = html + "<li data-id='" + new_id + "'><a href='#' class='select-next-line'>" + text + "</a></li>";
			}

			$("#next-lines").html(html);
			setUpNextLines();


			//if there are no next lines, replace the next-steps div to just hold the "add a new line div"

		});


	});


}