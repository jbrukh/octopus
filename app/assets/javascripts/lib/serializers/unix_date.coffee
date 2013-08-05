UnixDate =
  serialize: (value) ->
    moment(value).unix()

  deserialize: (value) ->
    moment.unix(value).toDate()

root = exports ? this
root.UnixDate = UnixDate