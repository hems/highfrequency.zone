$ = window.$ = require 'jquery'


delay = ( time, funk ) -> setInterval funk, time

$ ->


  $( '#video' )[0].volume = 0.5
  $( '#video' )[0].volume = 0
  $( '#video' )[0].play()

  $( '#video' )[0].addEventListener 'ended', ->


    $( '.header' ).animate opacity: 1

    $( '#video' ).animate opacity: 0
    
    delay 300, ->

      $( '#video' ).hide()
      $( '.content' ).show()

  $( window ).on 'resize', on_resize

  on_resize()


on_resize = ->

  video_h  = $( '#video' ).height()

  window_h = $( window ).height()

  $( 'video' ).css
    'margin-top': ( window_h - video_h ) / 2