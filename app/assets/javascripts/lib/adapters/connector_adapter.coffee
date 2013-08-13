get = Ember.get

App.ConnectorAdapter = Ember.Adapter.extend
  find: (record, id) ->
    return new Ember.RSVP.Promise (resolve, reject) =>
      all = findAll()
      all.then (data) =>
        result = data.findProperty 'id', id
        resolve(result)

  findAll: (klass, records) ->
    connector = App.ConnectorAdapter.connectorInstance
    connector.send('repository', { operation: 'list', local: true }).then (data) =>
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
    id = get record, primaryKey

    connector = App.ConnectorAdapter.connectorInstance
    connector.send('repository', { operation: 'delete', local: true, resource_id: id }).then () =>
      @didDeleteRecord record

  didDeleteRecord: (record) ->
    record.didDeleteRecord()

App.ConnectorAdapter.reopenClass
  connectorInstance: null