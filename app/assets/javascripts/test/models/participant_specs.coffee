describe 'App.Participant', ->
  beforeEach ->
    App.Store = DS.Store.extend {revision: 12}
    @participant = App.Participant.createRecord()

  describe 'in general', ->
    it 'has no properties', ->
      expect(@participant.hasProperty('foo')).toEqual(false)

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

  describe '#addProperty', ->
    it 'adds a property', ->
      property = @participant.addProperty('custom')
      expect(property.get('name')).toEqual('custom')
      properties = @participant.get('properties')
      expect(properties.length).toEqual(1)

    it 'doesnt add duplicate properties', ->
      @participant.addProperty('custom')
      @participant.addProperty('custom')
      properties = @participant.get('properties')
      expect(properties.length).toEqual(1)

  describe '#removeProperty', ->
    it 'removes property', ->
      property = @participant.addProperty('custom')
      @participant.removeProperty(property)
      expect(@participant.get('properties').length).toEqual(0)

  describe '#hasProperty', ->
    it 'indicates when has property', ->
      @participant.addProperty('custom')
      expect(@participant.hasProperty('custom')).toEqual(true)