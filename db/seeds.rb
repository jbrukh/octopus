# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create!({
  :email => 'admin@octopusmetrics.com',
  :password => 'password',
  :password_confirmation => 'password',
  :confirmed_at => DateTime.now,
  :role => 'admin'
})

user = User.create!({
  :email => 'user@octopusmetrics.com',
  :password => 'password',
  :password_confirmation => 'password',
  :confirmed_at => DateTime.now
})