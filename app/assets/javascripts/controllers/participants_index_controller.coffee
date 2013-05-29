App.ParticipantsIndexController = Em.ArrayController.extend
  needs: ['participant_selector']


  query: ''
  searchResults: null

  setupController: (controller, params) ->
    controller.set 'query', ''

  destroy: (participant) ->
    participant.deleteRecord();
    participant.get("transaction").commit()

  select: (participant) ->
    selector = @get('controllers.participant_selector')
    selector.select participant

  canSearch: (->
    @get('hasQuery')
  ).property('hasQuery')

  hasQuery: (->
    @get('query').length > 0
  ).property('query')

  cannotSearch: Ember.computed.not('canSearch')

  hasSearchResults: (->
    @get('searchResults') != null
  ).property('searchResults')

  resetSearchResults: (->
    @set 'searchResults', null unless @get 'hasQuery'
  ).observes('query')

  search: ->
    query = @get 'query'
    console.log "Searching for participants matching: '#{query}'"
    searchResults = App.Participant.find { query: query }
    @set 'searchResults', searchResults