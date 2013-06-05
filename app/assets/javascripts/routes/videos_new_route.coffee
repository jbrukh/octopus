App.VideosNewRoute = Ember.Route.extend
  model: ->
    @transaction = @get('store').transaction()
    return @transaction.createRecord(App.Video, {})

  deactivate: ->
    @transaction.rollback() if @transaction

  events:
    save: ->
      @currentModel.on 'didCreate', =>
        Ember.run.next this, =>
          @transitionTo 'video', @currentModel
      @transaction.commit()