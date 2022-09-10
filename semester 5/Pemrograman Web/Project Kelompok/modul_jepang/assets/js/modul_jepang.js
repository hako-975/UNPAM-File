let preloader = document.querySelector('#preloader');
if (preloader) {
	window.addEventListener('load', function() {
		preloader.remove();
	});
}
