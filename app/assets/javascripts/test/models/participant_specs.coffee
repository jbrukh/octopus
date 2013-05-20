describe 'App.Participant', ->
  beforeEach ->
    App.Store = DS.Store.extend {revision: 12}
    @participant = App.Participant.createRecord()

  describe '#fullName', ->
    beforeEach ->
      @participant.set 'firstName', 'Bob'
      @participant.set 'lastName', 'Jones'

    it 'is a combination of firstname, lastname', ->
      expect(@participant.get('fullName')).toEqual('Jones, Bob')

  describe '#age', ->
    it 'returns age', ->
      @participant.set 'birthday', '1983-06-01'
      expect(@participant.get('age')).toEqual(29)

    it 'returns null when birthday is null', ->
      @participant.set 'birthday', null
      expect(@participant.get('age')).toEqual(null)