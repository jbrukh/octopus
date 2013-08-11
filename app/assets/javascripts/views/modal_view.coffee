App.ModalView = Ember.View.extend
  layoutName: 'modal_layout'

  didInsertElement: ->
    this.$('.modal-backdrop').addClass('in')
    this.$('.modal').modal { backdrop: false }

  close: ->
    # send close to the controller when the modal has transitioned
    # this wil happen when the close animation has completed
    this.$('.modal').one "transitionend", (ev) =>
      @controller.send('close')

    this.$('.modal, .modal-backdrop').removeClass('in')