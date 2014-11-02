
$(document).ready(function(){
  $('input[type=submit]').on('click', function(e){
    e.preventDefault();
    if(notify.form().attr('method') == "post"){
      notify.create();
    }else{
      notify.update();
    }
  });

});

var notify = {
  el: ".notify",
  form: function(){
    return $(this.el);
  },

  update: function(){
    $.ajax({
      type: "PUT",
      url: notify.form().attr('action'), // will get the action url  "notify/:id"
      data: notify.form().serialize(), // serialize and display a representable data
      success: function(data){
        if (data.active){
          $('#' +data.id).html("active");
          console.log("hello this is true" + data.id );
        }else{
          form.closest('tr').fadeOut();
          console.log("hello this is false" + data.id );
        }
      },
      error: function(data){
      },
      dataType: 'JSON'
    });
  },

  create: function(){
    $.ajax({
      type: "POST",
      url: "/notifies",
      data: notify.form().serialize(),
      success: function(data){
        console.log(data)
        $("#form_modal").modal('hide');

        var table = $(".notify_table").children("tbody");

        var row = "<tr id='tr"+ data.id +"'>";
        row += "<td id='notify_id'>"+data.id +"</td>";
        row += "<td id='notify_name'>"+ data.name +"</td>";
        row += "<td id='notify_email'>"+ data.email +"</td>";
        row += "<td id='notify_message'>" + data.message +"</td>";
        row += "<td id='"+ data.id +" notify_status'>" + checker.check_status(data.active) +"</td><td>";
        row += "<div class='text-center'>";
        row += "<a href='/notify/"+ data.id +"/edit' class='btn btn-small btn-info'>edit</a>";
        row += "<a href='/notifies/notify/"+ data.id + "' class='btn btn-small btn-warning' style='margin-left:4px;'>notify</a>";
        row += "</div></td>";
        row += "</tr>";

        $(table).after(row);

        console.log("hello success");
      },
      error: function(data){
        console.log("Something went wrong");
      }, dataType: 'JSON'
    });
  }
}

 var checker =  {
   check_status: function(status_val){
     if(status_val){
       return "active";
     }else{
       return "inactive";
     };
   }
 }

