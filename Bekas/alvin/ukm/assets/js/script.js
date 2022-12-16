$('.offset-top-item').on('click', function(event) {
  event.preventDefault(); // Prevent the default <a> action.

  let tujuan = $(this).attr('href');
  let elemenTujuan = $(tujuan);

  let newScrollPosition = elemenTujuan.offset().top - 70;

  $('html, body').scrollTop(newScrollPosition); // Set the current vertical position of the scroll bar.
});