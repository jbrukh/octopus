App.ParticipantsIndexController = Em.ArrayController.extend App.Pageable,
  needs: ['currentParticipant']

  query: ''
  searchResults: null

  setupController: (controller, params) ->
    controller.set 'query', ''

  pageRoute: (->
    return 'participants.page'
  ).property()

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

  actions:
    destroyParticipant: (participant) ->
      participant.deleteRecord()
      @get('model').removeObject(participant)

    select: (participant) ->
      selector = @get('controllers.currentParticipant')
      selector.select participant

    search: ->
      query = @get 'query'
      console.log "Searching for participants matching: '#{query}'"
      searchResults = App.Participant.find { query: query }
      @set 'searchResults', searchResults
