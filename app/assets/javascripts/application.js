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
//= require jquery.ui.datepicker
//= require jquery_ujs
//= require bootstrap
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap
//= require highcharts
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

// Ticket preventivo vs Ticket correctivo

$(document).ready(function() {
	select = $('#ticket_ticket_type_id');
	$('#resolution_date_group').hide();

	select.change(function(){
		ticket_type = select.find(":selected").text();
		if (ticket_type == "Preventivo") {
			$('#resolution_date_group').slideDown();
		} else {
			$('#resolution_date_group').slideUp();
			$('#ticket_resolution_date').val('');
		}
		
	});
});

// jQuery Datepicker

$(function (){
	$('#ticket_resolution_date').datepicker({ minDate: 0, maxDate: "+2M"});
});

// Traducción al español
$(function($){
	$.datepicker.regional['es'] = {
		closeText: 'Cerrar',
		prevText: '<Ant',
		nextText: 'Sig>',
		currentText: 'Hoy',
		monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
		monthNamesShort: ['Ene','Feb','Mar','Abr', 'May','Jun','Jul','Ago','Sep', 'Oct','Nov','Dic'],
		dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
		dayNamesShort: ['Dom','Lun','Mar','Mié','Juv','Vie','Sáb'],
		dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','Sá'],
		weekHeader: 'Sm',
		dateFormat: 'dd/mm/yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''
	};
	$.datepicker.setDefaults($.datepicker.regional['es']);
});