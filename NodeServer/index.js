var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);

app.get('/', function(req, res){
  res.send('<h1>Iphone server for accelerometer data</h1>');
});



http.listen(3000,function(){
   console.log('listening on *:3000');
});

io.on('connection', function(clientSocket){
   console.log('\na user connected');

   clientSocket.on('disconnect', function(){
      console.log('\na user disconnected');
   });

   clientSocket.on('message', function(message){
      console.log("\nMessage from client: " + message)

      fs = require('fs');
      var filename = new Date().toISOString() +'.xml';
      fs.writeFile(filename, message, function (err) {
  if (err) return console.log(err);
  console.log('\nFile: ' + filename + ' saved.');
});
   });
});
