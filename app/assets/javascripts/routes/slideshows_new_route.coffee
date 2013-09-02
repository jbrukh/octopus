App.SlideshowsNewRoute = Ember.Route.extend
  model: ->
    @transaction = @get('store').transaction()
    return @transaction.createRecord(App.Slideshow, {})

  deactivate: ->
    @transaction.rollback() if @transaction

  actions:
    save: ->
      @currentModel.on 'didCreate', =>
        Ember.run.next this, =>
          @transitionTo 'slideshow', @currentModel
      @transaction.commit()