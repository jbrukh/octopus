User.create!({
  :email => 'jake@octopusmetrics.com',
  :password => 'please_change_me_12345',
  :password_confirmation => 'please_change_me_12345',
  :confirmed_at => DateTime.now,
  :role => 'admin',
  :first_name => 'Jake',
  :last_name => 'Brukh'
})

User.create!({
  :email => 'jonnii@octopusmetrics.com',
  :password => 'please_change_me_12345',
  :password_confirmation => 'please_change_me_12345',
  :confirmed_at => DateTime.now,
  :role => 'admin',
  :first_name => 'Jonathan',
  :last_name => 'Goldman'
})