App.RecordingsCloudPageRoute = Em.Route.extend
  setupController: ->
    @controllerFor('recordings.cloud').set('model', @currentModel)

  model: (params) ->
    App.Recording.findQuery({page: params.page_id})

  renderTemplate: ->
    @render 'recordings.cloud', { controller: 'recordingsCloud' }
