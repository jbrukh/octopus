App.DatePicker = Em.View.extend
  templateName: 'shared/controls/date_picker'
  didInsertElement: ->
    this.$('.datepickable')
      .datepicker()
      .on 'changeDate', (ev) =>
        date = moment(ev.date.valueOf())
        @set 'value', date.format('YYYY-MM-DD')

    this.$('.datepickable input').on 'input', (evt) =>
      out = evt.target.value
      parsed = moment(out, "YYYY-MM-DD")
      if parsed && parsed.isValid()
        @set 'value', parsed.format('YYYY-MM-DD')
      else
        @set 'value', null