App.ModalView = Em.View.extend
  classNames: 'modal fade'.w()

  didInsertElement: ->
     @$().modal 'show'

  willDestroyElement: ->
    @$().modal 'hide'