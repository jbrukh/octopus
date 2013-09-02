# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :analysis do
    state 'pending'
    algorithm 'fft'
    arguments {}
  end
end
