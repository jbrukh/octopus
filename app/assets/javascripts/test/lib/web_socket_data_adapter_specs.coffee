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

    it 'is in failed state', ->
      expect(@adapter.get('manager.currentState.name')).toEqual('failed')
      expect(@adapter.get('isFailed')).toBe(true)

    it 'has last error message', ->
      expect(@adapter.get('lastErrorMessage')).toEqual('device is already armed')