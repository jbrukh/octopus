App.StatusIndexController = Em.Controller.extend
  actions:
    connect: ->
      @get('connector').connect()

    clear: ->
      return unless confirm('Are you sure you want to clear the repository?')
      console.log 'clearing repository'
      @get('connector').clearRepository()
