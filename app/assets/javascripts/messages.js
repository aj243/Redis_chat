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
  var formattedSpeech = '<li class="mar-btm"><div class="media-body pad-hor"><div class="speech">'+
                        '<p class="media-heading">' + message.user_name + '</p><p>'+ message.content +
                        '<p class="speech-time"><i class="fa fa-clock-o fa-fw"></i>' + message.created_at + 
                        '</p></div></div></li>'
  $('#chat').append(formattedSpeech);
};

$(document).ready(ready);
$(document).on('page:load', ready);