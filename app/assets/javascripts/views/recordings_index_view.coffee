App.RecordingsIndexView = Ember.View.extend
  didInsertElement: ->
    this.$('#cant-record').tooltip
      placement: 'bottom'