// Transparent Navbar
let nav = document.querySelector('#navbar');


window.addEventListener('scroll', function() 
{
  if (window.pageYOffset > 50) 
  {
    nav.classList.add('bg-danger', 'shadow');
  } 
  else 
  {
    nav.classList.remove('bg-danger', 'shadow');
  }
});

// Preloader
let preloader = document.querySelector('#preloader');
if (preloader) {
	window.addEventListener('load', function() {
		preloader.remove();
	});
}

// Back to Top
let backtotop = document.querySelector('.back-to-top');

if (backtotop) {
	const toggleBacktotop = function() {
		if (window.scrollY > 100) {
			backtotop.classList.add('active');
		} else {
			backtotop.classList.remove('active');
		}
	}
	
	window.addEventListener('load', toggleBacktotop);
	window.addEventListener('scroll', toggleBacktotop);
}