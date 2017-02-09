$(document).ready(function(){

  setTimeout(function(){
    $('.alert').remove();
  }, 5000);

  $(document).on("click",'#reset_password',function(e){
    e.preventDefault();
    this.form.submit();
    this.disabled = true;
  })

  $(document).on("click",'#resend_confirmation',function(e){
    e.preventDefault();
    this.form.submit();
    this.disabled = true;
  })

});
