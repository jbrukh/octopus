describe 'App.Connector', ->
  beforeEach ->
    @connector = App.Connector.create()

  describe '#create', ->
    it 'is disconnected', ->
      expect(@connector.get('state')).toEqual('disconnected')

    it 'has no callbacks', ->
      expect(@connector.numCallbacks()).toEqual(0)

  describe '#connect', ->
    beforeEach ->
      spyOn(App.WebSocketFactory, 'createWebSocket').andReturn({})
      @connector.connect()

    it 'is connecting', ->
      expect(@connector.get('state')).toEqual('connecting')

  describe 'when connected', ->
    beforeEach ->
      @socket = {sendJson: () -> {}}
      spyOn(App.WebSocketFactory, 'createWebSocket').andReturn(@socket)
      @connector.connect()

    describe '#onResponse', ->
      beforeEach ->
        @connector.send('type', {id: 'abcd'})
        @connector.onResponse({id: 'abcd'})

      it 'removes registered callback', ->
        expect(@connector.numCallbacks()).toEqual(0)

    describe '#onOpen', ->
      beforeEach ->
        spyOn(@socket, 'sendJson')
        @connector.onOpen()

      it 'sends info message', ->
        expect(@socket.sendJson.calls[0].args[0].message_type).toEqual('info')

      it 'sends repository message', ->
        expect(@socket.sendJson.calls[1].args[0].message_type).toEqual('repository')