describe "a connector", ->
  beforeEach ->
    @connector = App.Connector.create()

  describe '#create', ->
    it 'should be disconnected', ->
      expect(@connector.get('state')).toEqual('disconnected')

  describe '#connect', ->
    beforeEach ->
      spyOn(App.WebSocketFactory, 'createWebSocket').andReturn({})
      @connector.connect()

    it 'should be connecting', ->
      expect(@connector.get('state')).toEqual('connecting')