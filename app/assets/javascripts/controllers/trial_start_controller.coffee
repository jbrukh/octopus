App.TrialStartController = Em.ObjectController.extend Ember.Evented,
  search: ->
    console.log 'Searching for participant'
    participants = App.Participant.find { query: @get('query') }
    @set 'participants', participants
    @set 'searched', true

  selectParticipant: (participant) ->
    @set 'model.participant', participant

  calibrate: ->
    @get('model').calibrate()
    Ember.run.next this, () -> @get('dataAdapter').start()

  run: ->
    @get('model').run()
    ##Ember.run.later this, (() ->
     # console.log 'going fullscreen'
    #  @trigger 'onFullscreen'), 500

    Ember.run.later this, (() ->
      console.log 'playing'
      @trigger 'onPlay'), 1000