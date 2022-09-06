var nav = document.querySelector('nav');

window.addEventListener('scroll', function () 
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