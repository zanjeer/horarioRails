$('document').ready(function(){
  $('#drop_curso').on('change',function(){
    if( $(this).val() > 0 ){
      $.ajax({
        url: "h",
        method: "POST",
        data: { id : $(this).val() },
        dataType: 'js',
        success: function(data){
          alert(data)
        }
      });
    }
  })
})
