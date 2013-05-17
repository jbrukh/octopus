describe 'App.Tagging', ->
  beforeEach ->
    App.Store = DS.Store.extend {revision: 12}
    @tag = App.Tagging.createRecord()

  describe '#extent', ->
    beforeEach ->
      @tag.set('extent', [30.3238478, 50.1411])

    it 'sets from/to', ->
      expect(@tag.get('fromMs')).toEqual(30)
      expect(@tag.get('toMs')).toEqual(50)