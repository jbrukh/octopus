App.StatusIndexController = Em.Controller.extend
  connect: ->
    @get('connector').connect()

  clear: ->
    return unless confirm('Are you sure you want to clear the repository?')
    console.log 'clearing repository'
    @get('connector').clearRepository()

  downloadConnector: ->
  	console.log 'downloading connector'
  	connector = "https://s3.amazonaws.com/erl-connector-downloads/OctopusConnector.zip"
  	file.download(connector)
