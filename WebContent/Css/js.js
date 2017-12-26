$(document).ready(function(){
      $('.parallax').parallax();
      $('.modal-trigger').leanModal();
      $('.modal').modal();
      $('select').material_select();
      $('.fixed-action-btn').openFAB();
      $('.fixed-action-btn').closeFAB();
      $('.materialboxed').materialbox();
      $('.collapsible').collapsible();
      $('.datepicker').pickadate({
    	    selectMonths: true, // Creates a dropdown to control month
    	    selectYears: 15 // Creates a dropdown of 15 years to control year
    	  });
      $('.fixed-action-btn.toolbar').closeToolbar();        
      });   

function ScrollTo(e)
{
   $("html body").animate({scrollTop : $("#"+e).offset().top}, 1000, "easeInOutQuart");
}
