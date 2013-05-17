class Tagging < ActiveRecord::Base
  belongs_to :user
  belongs_to :recording
end
