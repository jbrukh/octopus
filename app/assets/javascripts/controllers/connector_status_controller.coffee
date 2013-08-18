App.ConnectorStatusController = Em.Controller.extend
  connect: ->
    @get('connector').connect()