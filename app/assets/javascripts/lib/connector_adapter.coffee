get = Ember.get

App.ConnectorAdapter = Ember.Adapter.extend
  findAll: (klass, records) ->
    connector = App.ConnectorAdapter.connectorInstance
    connector.send('repository', { operation: 'list' }).then (data) =>
      @didFindAll klass, records, data

  didFindAll: (klass, records, data) ->
    collectionKey = get klass, 'collectionKey'
    dataToLoad = if collectionKey
      data[collectionKey]
    else
      data
    records.load klass, dataToLoad

  deleteRecord: (record) ->
    primaryKey = get record.constructor, 'primaryKey'

    connector = App.ConnectorAdapter.connectorInstance
    connector.send('repository', { operator: 'delete', resourceId: primaryKey }).then () =>
      @didDeleteRecord record

  didDeleteRecord: (record) ->
    record.didDeleteRecord()

App.ConnectorAdapter.reopenClass
  connectorInstance: null