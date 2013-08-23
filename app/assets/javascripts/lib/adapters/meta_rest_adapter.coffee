App.MetaRESTAdapter = Em.RESTAdapter.extend
  didFindQuery: (klass, records, params, data) ->
    collectionKey = Ember.get(klass, 'collectionKey')
    dataToLoad = if collectionKey then data[collectionKey] else data
    records.load(klass, dataToLoad)

    meta = data['meta']
    if meta
      records.set('meta', meta)

  ajaxSettings: (url, method) ->
    settings = @_super(url, method)
    settings.beforeSend = () -> NProgress.start()
    settings.complete = () -> NProgress.done()
    settings
