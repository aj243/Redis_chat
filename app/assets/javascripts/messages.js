var ready;
ready = function(){
  channels = $('#user_id').attr('value');
  if (channels) {
    array = JSON.parse(channels);
    source = new EventSource('/messages/events');
  
    for (var i in array){
      source.addEventListener(array[i], doStuff);     
    }
  };
}
var doStuff = function(response) {
  message = JSON.parse(response.data);
  $.ajax({
  url: "/messages/display_message",
  method: "POST",
  data: { "message" : message }
   });
};

$(document).ready(ready);
$(document).on('page:load', ready);