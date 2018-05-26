import {sumfact} from './sumfact';

const ctx = document.getElementById(`canvas`).getContext(`2d`),
    context = new (window.AudioContext || window.webkitAudioContext)();

let buffer = context.createBuffer(2, 100000, 22050);


//function playSound(buffer) {
//  var source = context.createBufferSource(); // creates a sound source
//  source.buffer = buffer;                    // tell the source which sound to play
//  source.connect(context.destination);       // connect the source to the context's destination (the speakers)
//  source.start(0);                           // play the source now
//                                             // note: on older systems, may have to use deprecated noteOn(time);
//}

//var playTone = function(freq, time, delay) {
//var oscillator = context.createOscillator();
//oscillator.type = 0; // sine wave
//
//setTimeout(function() {
//	oscillator.frequency.value = freq;
//	oscillator.connect(context.destination);
//	oscillator.start();
//}, delay);
//
//setTimeout(function() {
//	oscillator.stop();
//}, delay + time);
//}
//

var HEIGHT = 300;
function line(x1,y1,x2,y2) {
    ctx.beginPath();
    ctx.moveTo(x1, HEIGHT - y1);
    ctx.lineTo(x2, HEIGHT - y2);
    ctx.stroke();
}
var oldx = 0;
var oldy = 0;

var ch0 = buffer.getChannelData(0);
var ch1 = buffer.getChannelData(1);

for (var i = 0; i <= 100000; i++) {
    var sf = sumfact(i);
    var newx = i;
    var newy = Math.log(sf) / 2;
    //if (newy == newx) continue;
    //if (newy > Math.sqrt(newx)) continue;
    line(
        oldx, oldy*100,
        newx, newy*100
    );
    //	playTone(440+10000*((newy-5)/newx), 1, 1*i);
    oldx = newx;
    oldy = newy;
    ch0[i] = newy;
    ch1[i] = newy;
}

setTimeout(function() {

    var source = context.createBufferSource();
    source.buffer = buffer;
    source.connect(context.destination);
    source.start(0);
}, 5000);