describe 'App.Participant', ->
  beforeEach ->
    App.Store = DS.Store.extend {revision: 12}
    @participant = App.Participant.createRecord()

  describe '#fullName', ->
    beforeEach ->
      @participant.set('firstName', 'Bob')
      @participant.set('lastName', 'Jones')

    it 'is a combination of firstname, lastname', ->
      expect(@participant.get('fullName')).toEqual('Jones, Bob')