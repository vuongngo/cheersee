// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require foundation/foundation.interchange.js
//= require foundation/foundation.joyride.js
//= require turbolinks
//= require_tree .
//= require jquery.timepicker.js
//= require underscore
//= require gmaps/google
//= require jquery.remotipart
//= require sync
//= require bootstrap-datepicker

$(function(){ $(document).foundation(); });
$(function(){ $(document).foundation('joyride', 'start'); });
$(function () {  
  if ($('#set_challenges').length > 0) {  
    setTimeout(updateSetChallenge, 10000);  
  }  
});  
  
function updateSetChallenge() {  
	if ($('.set_challenge').length > 0) {  
	    var after = $('.set_challenge:first').attr('data-time');  
	  }  
	  else {  
	    var after = 0;  
	  };  
  $.getScript('/set_challenges/?after=' + after);  
  setTimeout(updateSetChallenge, 10000);  
}  

$(function () {  
  if ($('#join_challenges').length > 0) {  
    setTimeout(updateJoinChallenge, 10000);  
  }  
});  
  
function updateJoinChallenge() {  
	if ($('.join_challenge').length > 0) {  
	    var after = $('.join_challenge:first').attr('data-time');  
	  }  
	  else {  
	    var after = 0;  
	  };  
  $.getScript('/join_challenges/?after=' + after);  
  setTimeout(updateJoinChallenge, 10000);  
}  

function hideallsetForm() {
   setTimeout(clearallsetForm, 500);
};
function clearallsetForm(){
	var xyz = document.getElementsByClassName('new_set_challenge_comment')
  	var i;
	for (i = 0; i < xyz.length; i++) {	    
	   xyz[i].reset();
	};
}

function hidealljoinForm() {
   setTimeout(clearalljoinForm, 500);
};
function clearalljoinForm(){
	var zyx = document.getElementsByClassName('new_join_challenge_comment')
  	var y;
	for (y = 0; y < zyx.length; y++) {	    
	   zyx[y].reset();
	};
}