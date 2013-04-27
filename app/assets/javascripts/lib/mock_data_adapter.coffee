App.MockDataAdapter = Em.Object.extend
  frame:  null
  handle: null

  start: ->
    resolution  = @get 'resolution'
    channels    = @get 'channels'

    @frame = []
    @frame.push(Math.floor((Math.random()*100)+1)) for num in [0..channels]
    console.log "starting data adapter @ #{resolution}"
    @handle = setInterval((=> @tick()), resolution)

  tick: ->
    newFrame = []
    channels = @get('channels')
    for i in [0..channels]
      delta = 1 - Math.floor((Math.random()*3))
      val = Math.min(@frame[i] + delta, 100)
      val = Math.max(val, 0)
      newFrame.push(val)
    @frame = newFrame;

  stop: ->
    clearInterval @handle
    console.log 'stopping mock data adapter'

  sample: -> this.frame