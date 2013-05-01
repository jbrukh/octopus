App.StatusIndexController = Em.Controller.extend
  connect: ->
    @get('connector').connect()