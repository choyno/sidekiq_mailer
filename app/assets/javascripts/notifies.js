
$(document).ready(function(){

  $('.notify_create').on('click', function(e){
    e.preventDefault();
    $(".notify").attr("method", "post");
    $(".notify").attr("action", 'notifies/');
    helper.clear();
  });

  $('input[type=submit]').on('click', function(e){
    e.preventDefault();
    if(notify.form().attr('method') == "post"){
      notify.create();
    }else{
      notify.update();
    }
  });

  $(".notify_table").delegate('.notify_edit', 'click', function(e){
    e.preventDefault();
    var notify_id = $(this).closest('tr').attr("id");
    $(".notify").attr("method", "put");
    $(".notify").attr("action", 'notifies/'+ notify_id);
    notify.edit(notify_id);
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

        $("#form_modal").modal('hide');

           var rowSetter = $('#' + data.id);
           rowSetter.find("#notify_name").html(data.name);
           rowSetter.find("#notify_email").html(data.email);
           rowSetter.find("#notify_message").html(data.message);
           $('#' + data.id +"_notify_status").html(helper.check_status(data.active));
           console.log(data.name +" "+ data)

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

        var row = "<tr id='"+ data.id +"'>";
        row += "<td id='notify_id'>"+data.id +"</td>";
        row += "<td id='notify_name'>"+ data.name +"</td>";
        row += "<td id='notify_email'>"+ data.email +"</td>";
        row += "<td id='notify_message'>" + data.message +"</td>";
        row += "<td id='"+ data.id +"_notify_status'>" + helper.check_status(data.active) +"</td><td>";
        row += "<div class='text-center'>";
        row += "<a href='#form_modal' class='btn btn-small btn-info notify_edit' data-toggle='modal'>edit</a>";
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
  },

  edit: function(notify_id){
    var notify_details = $('#'+notify_id);
    var notify_name = notify_details.find("#notify_name").html();
    var notify_email = notify_details.find("#notify_email").html();
    var notify_message = notify_details.find("#notify_message").html();
    var notify_status = $("#form_modal").find("#notify_status").show()

    console.log( notify_details +" "+ notify_name+ " " + notify_email +" "+ notify_message  );

    var formSetter = $("#form_modal");
    formSetter.find("#notify_name").val(notify_name);
    formSetter.find("#notify_email").val(notify_email);
    formSetter.find("#notify_message").val(notify_message);

  }
}

 var helper =  {
   check_status: function(status_val){
     if(status_val){
       return "active";
     }else{
       return "inactive";
     };
   },

   clear: function(){
     var formResetter = $("#form_modal");
     formResetter.find("#notify_name").val("");
     formResetter.find("#notify_email").val("");
     formResetter.find("#notify_message").val("");
     formResetter.find("#notify_status").hide();
   }
 }



