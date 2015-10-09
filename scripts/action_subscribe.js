var Stomp = require('stompjs');

var url="/topic/"+process.argv[2]+".actions";
console.log("subscription url: "+url);

// Use raw TCP sockets
var client = Stomp.overTCP('api.servioticy.com', 1883);

client.connect('compose', 'shines', function(frame) {
client.subscribe(url, function(message) {
        console.log(message.body)
        process.exit()
  });
});
