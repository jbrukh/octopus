class Trial < ActiveRecord::Base
  belongs_to :user
  belongs_to :experiment
end
