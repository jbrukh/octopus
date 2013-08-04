get = Ember.get

App.ConnectorAdapter = Ember.Adapter.extend
  findAll: (klass, records) ->
    connector = App.ConnectorAdapter.connectorInstance

    connector.send('repository', {operation: 'list'}).then (data) =>
      @didFindAll klass, records, data

  didFindAll: (klass, records, data) ->
    collectionKey = get klass, 'collectionKey'
    dataToLoad = if collectionKey
      data[collectionKey]
    else
      data
    records.load klass, dataToLoad

App.ConnectorAdapter.reopenClass
  connectorInstance: null