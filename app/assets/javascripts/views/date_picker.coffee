App.DatePicker = Em.View.extend
  templateName: 'shared/controls/date_picker'
  didInsertElement: ->
    this.$('.datepickable')
      .datepicker()
      .on 'changeDate', (ev) =>
        date = moment(ev.date.valueOf())
        @set 'value', date.format('YYYY-MM-DD')