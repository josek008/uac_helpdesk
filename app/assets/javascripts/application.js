// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .


$(document).ready(function() {

	$("#widget_category").bind('ajax:success', function(evt, data, status, xhr){
		var select = $('#ticket_category_id');
		var length = data.length;

		select.empty();

		if (data !== null) {
			select.removeAttr('disabled');
			for(var j = 0; j < length; j++)
			{
				select.append($('<option>', { value: data[j].id })
					.text(data[j].name));
			}
		} else {
			select.attr('disabled', 'disabled');
		}
	});
});