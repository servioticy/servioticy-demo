var wifi = require('wifi-cc3000');
var tessel = require('tessel');
var http = require('http');
var blelib = require('ble-ble113a');

var config = require('./config')

var network = config.wifi_ssid; // put in your network name here
var pass = config.wifi_pass; // put in your password here, or leave blank for unsecured
var security = ''; // other options are 'wep', 'wpa', or 'unsecured'
var timeouts = 0;


var API_KEY = 'fS77Vy1srjaJ8yigEPD8mKmwFlwMFxBDWpbeCX';
var SO_ID = '1429722492407a5707b53b0174d81aacbac7fb8bd9a91';

var led1 = tessel.led[0].output(0); // Green -- Sensing
var led2 = tessel.led[1].output(0); // Blue  -- Pushing data

var ble = blelib.use(tessel.port['A']);


function pushData(jsondata, id, stream) {

  console.log("Pushing to ID ("+id+") data ("+jsondata+")");

  var options = {
    hostname: 'api.servioticy.com',
    port: 9090,
    path: '/'+id+'/streams/'+stream,
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': API_KEY
    }
  };

  var req = http.request(options, function(res) {
    console.log('Status Code: ' + res.statusCode);
    led2.toggle();
    res.setEncoding('utf8');
    res.on('data', function (chunk) {
      console.log('Returned: ' + chunk);
    });
  });

  req.on('error', function(e) {
    console.log('problem with request: ' + e.message);
  });

  led2.toggle();
  req.write(jsondata);
  req.end();
}

function connect() {
  console.log("Connecting to WiFi");
  wifi.reset();
  wifi.connect({
      security: security
      , ssid: network
      , password: pass
      , timeout: 30 // in seconds
  });
}

/************** Handlers ********************/

wifi.on('connect', function(data){
  console.log("connected to WiFi", data);
});


wifi.on('disconnect', function(data){
  console.log("disconnect emitted", data);
});

wifi.on('error', function(err){
  console.log("error emitted", err);
});



/**********************/



var discovered = [];
ble.startScanning();


ble.on('ready', function () {
  console.log('Starting sensing loop');
  // Loop forever
  setImmediate(function loop(){
      ble.stopScanning();
      ble.removeAllListeners('discover');
      var eventTime=0;
      while(discovered.length > 0) {

                  peripheral = discovered.pop();
                  console.log("MAC:", peripheral.address.toString(), ", rssi: ", peripheral.rssi);
                  if(eventTime == 0)
                      eventTime = parseInt((Date.now()/1000),10);
                  else
                      eventTime++;
                  led1.toggle();
                  if(wifi.isConnected()) {
                    var jsondata='{"channels": {"beacon": {"current-value":"'+peripheral.address.toString()+'"}, "rssi": {"current-value":'+peripheral.rssi+'} }, "lastUpdate":'+eventTime+'}';
                    console.log(jsondata);
                    pushData(jsondata,SO_ID, "detected");
                  } else
                    connect();
                  
                  led1.toggle();
          }
          console.log("***********");
          ble.startScanning();
          setTimeout(loop, 5000);

          ble.on('discover', function(peripheral) {
                discovered.push(peripheral);
          });
    });
});




