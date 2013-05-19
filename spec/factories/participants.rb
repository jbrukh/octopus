# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :participant do
    first_name 'James'
    last_name 'Smith'
    birthday 24.years.ago
    email 'james@example.com'
    gender 'm'
    user { User.first }
  end
end
