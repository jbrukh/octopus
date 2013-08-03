describe 'App.RecordingsCloudController', ->
  beforeEach ->
    App.Store = DS.Store.extend {revision: 12}
    @controller = App.RecordingsCloudController.create()

  describe '#destroy', ->
    beforeEach ->
      @recording = App.Recording.createRecord()
      spyOn(@recording, 'deleteRecord')

      @controller.destroy(@recording)

    it 'deletes record', ->
      expect(@recording.deleteRecord).toHaveBeenCalled()