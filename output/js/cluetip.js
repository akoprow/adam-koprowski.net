$(document).ready(function() {

	$('.author').cluetip({
		showTitle: false, cluetipClass: 'author', width: '780px', attribute: 'rel', 
		 arrows: false, cursor: 'crosshair', hoverClass: 'highlight' });

	$('img.book-comment').cluetip({
		splitTitle: '|', arrows: true, local: true, hideLocal: true, cluetipClass: 'jtip',
		dropShadow: false, cursor: 'crosshair', tracking: true});

	$('a.imdb-info').cluetip({
		arrows: true, local: true, hideLocal: true, showTitle: false, cluetipClass: 'jtip',
		dropShadow: false, cursor: 'crosshair', width: '400px'});

});
