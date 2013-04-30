App.TheoriesIndexController = Em.ArrayController.extend

  destroy: (theory) ->
    #if confirm 'Are you sure you want to delete this theory'
      theory.deleteRecord()
      @get('store').commit()