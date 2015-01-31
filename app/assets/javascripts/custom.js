$(document).ready(function() {
 
  $("#owl-demo").owlCarousel({
 
      items : 3,
      itemsDesktop : [1000, 2],
      itemsDesktopSmall : [900, 1],
      itemsTablet : [600, 1],
      itemsMobile : false,
      navigation : true, // Show next and prev buttons
      slideSpeed : 300,
      paginationSpeed : 400,
 
      // "singleItem:true" is a shortcut for:
      // items : 1, 
      // itemsDesktop : false,
      // itemsDesktopSmall : false,
      // itemsTablet: false,
      // itemsMobile : false
 
  });
 
 $("#owl-demo2").owlCarousel({
 
      items : 3,
      itemsDesktop : [1000, 2],
      itemsDesktopSmall : [900, 1],
      itemsTablet : [600, 1],
      itemsMobile : false,
      navigation : true, // Show next and prev buttons
      slideSpeed : 300,
      paginationSpeed : 400,
 
 
      // "singleItem:true" is a shortcut for:
      // items : 1, 
      // itemsDesktop : false,
      // itemsDesktopSmall : false,
      // itemsTablet: false,
      // itemsMobile : false
 
  });
});