$(document).ready(function () {
 //console.log ('i am a cookie');
$.cookies.get('myCookie')
 
	//set window scroll position if cookie is set
	window.scroll(0, $.cookies.get('myCookie'));
	//unset cookie after setting scroll position
	$.cookies.del('myCookie');
 
	//make this class objects keep page scroll position
	$('.abclink').each(function() {
	$('.abclink').click(function() {
		console.log ('i am a cookie');
		$.cookies.set('myCookie', getPageScroll());
	});
});
 
});
 
//this function simply gets the window scroll position, works in all browsers
function getPageScroll() {
	var yScroll;
	if (self.pageYOffset) {
		yScroll = self.pageYOffset;
	} else if (document.documentElement && document.documentElement.scrollTop) {
		yScroll = document.documentElement.scrollTop;
	} else if (document.body) {
		yScroll = document.body.scrollTop;
	}
	return yScroll
}