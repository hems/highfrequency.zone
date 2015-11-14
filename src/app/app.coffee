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

  navigator.getUserMedia constraints, ((stream) ->
    source = context.createMediaStreamSource(stream)
    scope.addSignal source, '#243F24'
  ), (error) ->
    console.error 'getUserMedia error:', error