describe 'App.Settings', ->
  beforeEach ->
    @settings = App.Settings.createRecord()

  describe '#createRecord', ->
    it 'should', ->
      expect(@settings.adapters.selected).toEqual('live')