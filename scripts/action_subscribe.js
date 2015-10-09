var Stomp = require('stompjs');

var url="/topic/"+process.argv[2]+".actions";
console.log("subscription url: "+url);

// Use raw TCP sockets
var client = Stomp.overTCP('api.servioticy.com', 1883);

client.connect('compose', 'shines', function(frame) {
   console.log("connected");
	client.subscribe(url, function(message) {
		  console.error("Action requested");
		  if (message.body) {
      		console.error("got message with body " + message.body);
    	  } else {
      		console.error("got empty message");
    	  }
        process.exit()
  });
});

process.on('uncaughtException', function (err) {
    console.error((new Date).toUTCString() + ' uncaughtException:', err.message)
    console.error(err.stack)
    process.exit(1)
});
