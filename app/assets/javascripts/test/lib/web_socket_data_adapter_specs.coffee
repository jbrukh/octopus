describe "App.WebSocketDataAdapter", ->
  beforeEach ->
    @adapter = App.WebSocketDataAdapter.create()

  describe '#onConnect', ->
    beforeEach ->
      spyOn(App.WebSocketFactory, 'createWebSocket').andReturn({})
      response = {
        id: "2",
        message_type: "connect",
        success: false,
        err: "device is already armed",
        status: "armed"
      }
      @adapter.onConnect(response)

    it 'has state in use', ->
      expect(@adapter.get('manager.currentState.name')).toEqual('failed')