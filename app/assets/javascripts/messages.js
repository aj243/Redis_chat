var ready;
ready = function(){
  channels = $('#user_id').attr('value');
  if (channels) {
    array = JSON.parse(channels);
    source = new EventSource('/messages/events');
  
    for (var i in array){
      console.log(array[i]);
      source.addEventListener(array[i], doStuff);     
    }
  };
}
var doStuff = function(response) {
  message = JSON.parse(response.data);
  $('#chat').append($('<li>').text(message.user_name + ": " + message.content))

};

$(document).ready(ready);
$(document).on('page:load', ready);