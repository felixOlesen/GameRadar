// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//
//= require jquery3
//= require jquery_ujs
//= require bootstrap-sprockets
//= require form-validation
//= require activestorage
//= require turbolinks
//= require_tree .


//Loads functions after pages
$(document).on('turbolinks:load', function() {
    //Function to hide haml tags with the "hide_class" class.
    $('#contact_button').click(function(event){
        $('.hide_class').hide();
        event.preventDefault();
    });

    //Used in forums index page to expand images when hovering over them.
    $(".hover_expand").hover(function(){
      $(this).css("width", "125px");
      $(this).css("height", "125px");
      }, function(){
      $(this).css("width", "75px");
      $(this).css("height", "75px");
    });
});
