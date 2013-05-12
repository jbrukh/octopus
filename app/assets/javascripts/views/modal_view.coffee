App.ModalView = Em.View.extend
  classNames: 'modal fade in form-custom-field-modal'.w()
  didInsertElement: ->
     @$().modal 'show'
  willDestroyElement: ->
    @$().modal 'hide'