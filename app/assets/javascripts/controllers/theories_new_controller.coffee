App.TheoriesNewController = Ember.Controller.extend
  startEditing: ->
    @transaction = @get('store').transaction()
    @set('model', @transaction.createRecord(App.Theory, {}))

  stopEditing: ->
    @transaction.rollback() if @transaction
    @transaction = null

  save: ->
    @transaction.commit()
    @transaction = null

  transitionAfterSave: (->
    if (@get('content.id'))
      @transitionToRoute 'theory', @get('content')
  ).observes('content.id')