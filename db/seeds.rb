# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create!({
  :email => 'me@jonnii.com',
  :password => 'password',
  :password_confirmation => 'password',
  :confirmed_at => DateTime.now
})

result = Result.create!({
  :data => File.new("#{Rails.root}/spec/fixtures/files/odf.data")
})

Recording.create({
  :state => 'uploaded',
  :user => user,
  :result => result
})