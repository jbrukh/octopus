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
      spyOn(App.WebSocketFactory, 'createWebSocket').andReturn({send: () -> {}})
      @connector.connect()

    describe '#onResponse', ->
      beforeEach ->
        @connector.send('type', {id: 'abcd'})
        @connector.onResponse({id: 'abcd'})

      it 'removes registered callback', ->
        expect(@connector.numCallbacks()).toEqual(0)