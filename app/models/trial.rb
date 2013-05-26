class Trial < ActiveRecord::Base
  belongs_to :user
  belongs_to :experiment
  belongs_to :participant
end
