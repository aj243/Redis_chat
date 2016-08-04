var ready;
ready = function(){
  channels = $('#user_id').attr('data-user-channels');  //getting all the subscribed channels for the cuurent user
  if (channels) {
    array = JSON.parse(channels); //converting string to array
    source = new EventSource('/messages/events'); //Listens to Server side events
    for (var i in array){
      source.addEventListener(array[i], doStuff);     
    }
  };

}

// The function below appends the messages recived to the chat window
var doStuff = function(response) {
  message = JSON.parse(response.data);
  userId = $('#user_id').attr('data-user-id');
  var messageAlignment;

  // Condition check for the message alignment
  if (userId == message.user_id) {
      messageAlignment = 'media-body pad-hor';
  } else {
      messageAlignment = 'media-body pad-hor speech-right';
  }
  var formattedSpeech = '<li class="mar-btm"><div class="'+ messageAlignment + '"><div class="speech">'+
                        '<p class="media-heading">' + message.user_name + '</p><p>'+ message.content +
                        '<p class="speech-time"><i class="fa fa-clock-o fa-fw"></i>' + 
                        moment(message.created_at).format("DD-MM-YY h:mm:ss A") + '</p></div></div></li>'
  $('#chat').append(formattedSpeech);
};

$(document).ready(ready);
$(document).on('page:load', ready);