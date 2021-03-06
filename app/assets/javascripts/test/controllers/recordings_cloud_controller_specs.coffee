describe 'App.RecordingsCloudController', ->
  beforeEach ->
    @controller = App.RecordingsCloudController.create()

  describe '#destroy', ->
    beforeEach ->
      @recording = App.Recording.create()
      spyOn(@recording, 'deleteRecord')

      @controller.destroy(@recording, false)

    it 'deletes record', ->
      expect(@recording.deleteRecord).toHaveBeenCalled()