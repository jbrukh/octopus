App.ParticipantsIndexController = Em.ArrayController.extend
  needs: ['currentParticipant']

  query: ''
  searchResults: null

  setupController: (controller, params) ->
    controller.set 'query', ''

  destroyParticipant: (participant) ->
    participant.deleteRecord()

  select: (participant) ->
    selector = @get('controllers.currentParticipant')
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