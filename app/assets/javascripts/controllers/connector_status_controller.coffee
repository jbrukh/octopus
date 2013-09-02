App.ConnectorStatusController = Em.Controller.extend
  actions:
    connect: ->
      @get('connector').connect()