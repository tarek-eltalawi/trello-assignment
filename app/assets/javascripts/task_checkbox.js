$(document).ready(function() {  
  $(".checkbox").change(function() {
    var check = $(this).find("input");
    // var x = $(this).attr('id') ;
    if(check.is(":checked")){     
      $(this).find("p").css('text-decoration', 'line-through');
    }
    else{
      $(this).find("p").css('text-decoration', 'none');
    }
    $.ajax({
      // alert ("hellooooo");
      type: 'POST',
      url: '/tasks/taskstate',
      data: {
        id: $(check).attr('id')
      }
    });
  });
});