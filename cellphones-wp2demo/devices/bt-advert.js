var tessel = require('tessel');
var blelib = require('ble-ble113a');

var ble_a = blelib.use(tessel.port['A']);

var led1 = tessel.led[0].output(1); // Green
var led2 = tessel.led[1].output(0); // Blue

var intCon;
var intAdv;

ble_a.on('ready', function(err) {
	if (err) return console.log(err);

	console.log('started advertising on A...');
	ble_a.startAdvertising();
	advCycle_a();
});

function advCycle_a() {
	intAdv = setInterval(function() {
		led1.toggle();
	}, 1000);
}