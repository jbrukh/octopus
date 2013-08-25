App.DownloadConnectorController = Em.Controller.extend
  downloadConnector: ->
  	console.log 'downloading connector'
  	connector = "https://s3.amazonaws.com/erl-connector-downloads/OctopusConnector.zip"
  	file.download(connector)
