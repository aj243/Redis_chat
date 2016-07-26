var ready;
ready = function(){
	source = new EventSource('/messages/events');
	console.log('came here')
  source.addEventListener ('messages.create', function(response) {
		message = JSON.parse(response.data);
  	$('#chat').append($('<li>').text(message.name + ": " + message.content))
  	console.log("#{message.name}");
  	console.log('Event listening');
  	console.log(response.data);
  })
};

$(document).ready(ready);
$(document).on('page:load', ready);