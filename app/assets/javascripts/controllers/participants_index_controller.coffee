App.ParticipantsIndexController = Em.ArrayController.extend
  needs: ['currentParticipant']

  query: ''
  searchResults: null

  previousPage: (->
    @get('content.meta.page') - 1
  ).property('content.meta.page')

  nextPage: (->
    @get('content.meta.page') + 1
  ).property('content.meta.page')

  pages: (->
    currentPage = @get('content.meta.page')
    from = currentPage - 3
    to = currentPage + 3
    Em.Object.create({pageNumber: page}) for page in [from..to]
  ).property('content.meta.total_pages', 'content.meta.page')

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