$(document).ready(function() {
 
var x = 5;
  $("#owl-demo").owlCarousel({
 
      items : 3,
      itemsDesktop : [1000, 2],
      itemsDesktopSmall : [900, 1],
      itemsTablet : [600, 1],
      itemsMobile : false,
      navigation : true, // Show next and prev buttons
      slideSpeed : 300,
      paginationSpeed : 400, 
  });
 
 $("#owl-demo2").owlCarousel({
 
      items : 3,
      itemsDesktop : [1000, 2],
      itemsDesktopSmall : [900, 1],
      itemsTablet : [600, 1],
      itemsMobile : false,
      navigation : true, // Show next and prev buttons
      slideSpeed : 300,
      paginationSpeed : 400 
  });

   $('.link').on('click', function(event){
    var $this = $(this);
    if($this.hasClass('clicked')){
      $this.removeAttr('style').removeClass('clicked');
      x = 7;
    } else{
      d = document.getElementsByClassName('clicked');
      for (i = 0; i < d.length; i++) {
            d[0].removeAttribute("style");
            $(d[0]).removeClass('clicked');
      }
      $this.css('background','#040707').addClass('clicked');
    }
  });
});