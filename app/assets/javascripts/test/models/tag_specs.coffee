describe 'App.Tag', ->
  beforeEach ->
    @tag = App.Tag.create()

  describe '#extent', ->
    beforeEach ->
      @tag.set('extent', [30.3238478, 50.1411])

    it 'sets from/to', ->
      expect(@tag.get('from')).toEqual(30)
      expect(@tag.get('to')).toEqual(50)