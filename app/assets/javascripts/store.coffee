App.Store = DS.Store.extend
  revision: 12

DS.RESTAdapter.configure "plurals",
  theory: "theories"
  video: "videos"

DS.RESTAdapter.reopen
  namespace: 'api'