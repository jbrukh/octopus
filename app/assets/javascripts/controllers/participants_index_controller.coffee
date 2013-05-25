App.ParticipantsIndexController = Em.ArrayController.extend
  query: ''

  setupController: (controller, params) ->
    controller.set 'query', ''

  destroy: (participant) ->
    participant.deleteRecord();
    participant.get("transaction").commit()

  canSearch: (->
    @get('hasQuery')
  ).property('hasQuery')

  hasQuery: (->
    @get('query').length > 0
  ).property('query')

  cannotSearch: Ember.computed.not('canSearch')

  search: ->
    query = @get 'query'
    results = @get('store').findQuery App.Participant, { query: query }
    @set 'model', results