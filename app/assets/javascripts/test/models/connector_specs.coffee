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

  describe '#next', ->
    beforeEach ->
      @connector.next {id: 'abcd'}

    it 'has callback', ->
      expect(@connector.numCallbacks()).toEqual(1)

  describe 'when not connected', ->
    describe '#send', ->
      beforeEach ->
        @connector.send('type', {id: 'abcd'})

      it 'has buffered messages', ->
        expect(@connector.hasBufferedMessages()).toEqual(true)

  describe 'when connected', ->
    beforeEach ->
      @socket = {sendJson: () -> {}}
      spyOn(App.WebSocketFactory, 'createWebSocket').andReturn(@socket)
      @connector.connect()
      @connector.set 'state', 'connected'

    describe '#onMessage', ->
      beforeEach ->
        @connector.send('type', {id: 'abcd'})
        @connector.onMessage({id: 'abcd'})

      it 'removes registered callback', ->
        expect(@connector.numCallbacks()).toEqual(0)

    describe '#onOpen', ->
      beforeEach ->
        spyOn @socket, 'sendJson'
        @connector.onOpen()

      it 'sends info message', ->
        expect(@socket.sendJson.calls[0].args[0].message_type).toEqual('info')

    describe '#onInfo', ->
      beforeEach ->
        spyOn @socket, 'sendJson'
        @connector.onInfo({device_name: 'CARL!', version: '3.0'})

      it 'sets device name',  ->
        expect(@connector.get('device_name')).toEqual('CARL!')

      it 'sets device version',  ->
        expect(@connector.get('version')).toEqual('3.0')

      it 'sends list repository message', ->
        args = @socket.sendJson.calls[0].args[0]
        expect(args.message_type).toEqual('repository')
        expect(args.operation).toEqual('list')

    describe '#onRepository', ->
      beforeEach ->
        @connector.onRepository {resource_infos: [{},{}]}

      it 'sets resources', ->
        expect(@connector.get('resources.length')).toEqual(2)

    describe '#clearRepository', ->
      beforeEach ->
        spyOn @socket, 'sendJson'
        @connector.clearRepository()
        @connector.set('resources', Em.A([{}, {}]))

      it 'sends clear repository message', ->
        args = @socket.sendJson.calls[0].args[0]
        expect(args.message_type).toEqual('repository')
        expect(args.operation).toEqual('clear')