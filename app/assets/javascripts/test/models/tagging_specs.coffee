describe 'App.Tagging', ->
  beforeEach ->
    @tag = App.Tagging.create()

  describe '#extent', ->
    beforeEach ->
      @tag.set('extent', [30.3238478, 50.1411])

    it 'sets from/to', ->
      expect(@tag.get('fromMs')).toEqual(30)
      expect(@tag.get('toMs')).toEqual(50)