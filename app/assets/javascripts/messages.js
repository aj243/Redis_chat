var ready;
ready = function(){
	id = $('#user_id').attr("value");
	array = JSON.parse(id);
	console.log(id);
	source = new EventSource('/messages/events');

	for (var i=0; i<array.length; i++){
        source.addEventListener(array[i], doStuff);
  };  
};

var doStuff = function(response) {
	message = JSON.parse(response.data);
	$('#chat').append($('<li>').text(message.name + ": " + message.content))
};

$(document).ready(ready);
$(document).on('page:load', ready);