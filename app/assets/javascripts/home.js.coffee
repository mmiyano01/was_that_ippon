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
              window.onYouTubeIframeAPIReady =
                ->
                  target = obj.target
                  id = obj.id
                  width = obj.width
                  height = obj.height
                  loadPlayer(target,id,width,height)
          error:
            (xhr, status, thrown)->
              loadScript()
        )
      else
        target = obj.target
        id = obj.id
        width = obj.width
        height = obj.height
        loadPlayer(target,id,width,height)


  loadPlayer =
    (target,id,width,height)->
      if !player 
        player = new YT.Player(target,
          width: width
          height: height
          host: 'https://www.youtube.com',
          videoId: id
          playerVars:
            hl:'en_EN'
            fs:1
            hd:1
            rel:0
            showinfo:0
            autohide:1
            theme:'light'
        )
      else
        player.loadVideoById(id)


  movie =
    (video_id) ->
      target: 'ytPlayer'
      id: video_id
      width:750
      height:500

  constructor: ->
    @selected_video_id = ko.observable("")
    @dialog_opened = ko.observable(false)

  selectVideo: (video_id) ->
    @selected_video_id video_id
    @dialog_opened true
    movie_data = movie(@selected_video_id())
    loadScript(movie_data)

  closeDialog: ->
    @dialog_opened false
    player.stopVideo()
$ ->
  ko.applyBindings new HomeViewModel()