describe 'App.ResultData', ->
  beforeEach ->
    @resultData = App.ResultData.create()

  #describe 'with parallel data', ->
  #  beforeEach ->
  #    # need to find a way to actually get a
  #    # binary file here...
  #    # http://stackoverflow.com/questions/14190312/how-do-i-load-a-binary-file-during-javascript-unit-test
  #    reader = new FileReader()
  #    reader.onload = () =>
  #      @arrayBuffer = reader.result
  #    reader.readAsArrayBuffer(file)

  #  describe '#populateFromArrayBuffer', ->
  #    beforeEach ->
  #      @resultData.populateFromArrayBuffer(@arrayBuffer)

  #    it 'has parallel storage mode', ->
  #      expect(@resultData.get('storageMode')).toEqual('parallel')