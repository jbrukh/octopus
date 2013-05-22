App.ParticipantsIndexController = Em.ArrayController.extend
  query: ''

  destroy: (participant) ->
    participant.deleteRecord();
    participant.get("transaction").commit()

  canSearch: (->
    return @get('query').length > 0
  ).property('query')

  cannotSearch: Ember.computed.not('canSearch')

  search: ->
    query = @get 'query'
    results = @get('store').findQuery App.Participant, { query: query }
    @set 'model', results