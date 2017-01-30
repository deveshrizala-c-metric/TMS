$(function(){
  setTimeout(function(){
    $('.alert').remove();
  }, 5000);
 });

document.getElementById("reset_password").onclick = function() {
    //disable
    this.disabled = true;

    //do some validation stuff
}

document.getElementById("resend_confirmation").onclick = function() {
    //disable
    this.disabled = true;

    //do some validation stuff
}