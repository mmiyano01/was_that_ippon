class HomeViewModel
  player = ''
  loadScript =
    (obj)->
      if (document.getElementById('ytPlayer').tagName != 'IFRAME')
        $.ajax(
          url:"http://www.youtube.com/iframe_api/"
          dataType:"script"
          success:
            (data)->
              target = obj.target
              id = obj.id
              start_at = obj.start_at
              end_at = obj.end_at
              width = obj.width
              height = obj.height
              window.onYouTubeIframeAPIReady =
                ->
                  loadPlayer(target,id,start_at,end_at,width,height)
              window.onPlayerReady = 
                (event)->
                  player.loadVideoById({videoId: id, startSeconds: start_at, endSeconds: end_at})
              window.onPlayerStateChange = 
                (event)->
                  if (event.data == YT.PlayerState.ENDED)
                    player.seekTo(start_at)
          error:
            (xhr, status, thrown)->
              loadScript()
        )

      else
        target = obj.target
        id = obj.id
        start_at = obj.start_at
        end_at = obj.end_at
        width = obj.width
        height = obj.height
        loadPlayer(target,id,start_at,end_at,width,height)


  loadPlayer =
    (target,id,start_at,end_at,width,height)->
      if !player 
        player = new YT.Player(target,
          width: width
          height: height
          host: 'https://www.youtube.com',
          playerVars:
            hl:'en_EN'
            controls:0
            disablekb:1
            loop:1
            fs:1
            hd:1
            rel:0
            showinfo:0
            autohide:1
            theme:'light'
          events: {
            'onReady': onPlayerReady,
            'onStateChange': onPlayerStateChange
          }  
        )
      else
        player.loadVideoById({videoId: id, startSeconds: start_at, endSeconds: end_at})


  movie =
    (video_id, start_at, end_at) ->
      target: 'ytPlayer'
      id: video_id
      start_at: start_at
      end_at: end_at
      width:750
      height:500

  constructor: ->
    @selected_video_id = ko.observable("")
    @dialog_opened = ko.observable(false)

    @answer = ko.observable("")
    @result = ko.observable("")

  selectVideo: (video_id, answer, start_at, end_at) ->
    @selected_video_id video_id
    @answer answer
    @dialog_opened true
    @result ''

    movie_data = movie(@selected_video_id(), start_at, end_at)
    loadScript(movie_data)

  closeDialog: ->
    @dialog_opened false
    @result ''
    player.stopVideo()

  clickedResult: (guess) ->
     @result(guess == @answer())
$ ->
  ko.applyBindings new HomeViewModel()