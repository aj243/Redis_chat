var ready;
ready = function(){
	source = new EventSource('/messages/events');
  source.addEventListener ('channel_1', function(response) {
		message = JSON.parse(response.data);
  	$('#chat').append($('<li>').text(message.name + ": " + message.content))
  	console.log('Event listening');
  	console.log(response.data);
  })
};

$(document).ready(ready);
$(document).on('page:load', ready);