App.register 'connector:instance', App.Connector
App.inject 'controller', 'connector', 'connector:instance'