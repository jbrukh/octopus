App.DownloadConnectorController = Em.Controller.extend
  actions:
    downloadConnector: ->
    	console.log 'downloading connector'
    	connector = "https://s3.amazonaws.com/erl-connector-downloads/OctopusConnector.zip"
    	file.download(connector)
