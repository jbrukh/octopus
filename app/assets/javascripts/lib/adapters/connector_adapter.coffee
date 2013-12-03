# get = Ember.get

# App.ConnectorAdapter = Ember.Adapter.extend
#   find: (record, id) ->
#     return new Ember.RSVP.Promise (resolve, reject) =>
#       all = @findQuery({})
#       all.then (data) =>
#         result = data.findProperty 'id', id
#         resolve(result)

#   findQuery: (klass, records, params) ->
#     connector = App.ConnectorAdapter.connectorInstance
#     connector.send('repository', { operation: 'list', local: true }).then (data) =>
#       @didFindQuery klass, records, data

#   didFindQuery: (klass, records, data) ->
#     collectionKey = get klass, 'collectionKey'
#     dataToLoad = if collectionKey
#       data[collectionKey]
#     else
#       data
#     records.load klass, dataToLoad

#   createRecord: (record) ->
#     return new Ember.RSVP.Promise (resolve, reject) =>
#       record.didCreateRecord()
#       resolve(record)

#   deleteRecord: (record) ->
#     primaryKey = get record.constructor, 'primaryKey'
#     id = get record, primaryKey

#     connector = App.ConnectorAdapter.connectorInstance
#     connector.send('repository', { operation: 'delete', local: true, resource_id: id }).then () =>
#       @didDeleteRecord record

#   didDeleteRecord: (record) ->
#     record.didDeleteRecord()

# App.ConnectorAdapter.reopenClass
#   connectorInstance: null