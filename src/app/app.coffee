$ = window.$ = require 'jquery'

$ ->

  Oscilloscope = require('./oscilloscope.min.js')
  context = new (window.AudioContext)

  # setup canvas
  canvas = document.querySelector('.visualizer')
  canvas.width = window.innerWidth
  canvas.height = window.innerHeight

  options = 
    stroke: 3
    glow: 0.1
    buffer: 1024 * 8

  # attach oscilloscope
  scope = new Oscilloscope( canvas, options )

  # get user microphone
  constraints = 
    video: false
    audio: true

  video = document.createElement "video"
  video.setAttribute "src", "videos/dec05.mp4"

  video.controls = true;
  video.autoplay = true;

  document.body.appendChild(video);

  source = context.createMediaElementSource(video);

  gainNode = context.createGain();
  gainNode.gain.value = 0.5;

  filter = context.createBiquadFilter();
  filter.type = 1;
  filter.frequency.value = 4000;

  source.connect gainNode
  gainNode.connect filter


  scope.addSignal source, '#243F24'

  filter.connect context.destination
  # source.connect context.destination
  
  $( 'video' )[0].addEventListener 'ended', ->

    $( 'video' ).animate opacity: 0

    scope = new Oscilloscope( canvas, options )

    navigator.getUserMedia constraints, ((stream) ->
      source = context.createMediaStreamSource(stream)
      scope.addSignal source, '#243F24'
    ), (error) ->
      console.error 'getUserMedia error:', error