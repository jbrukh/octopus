class Result < ActiveRecord::Base
  has_one :recording

  has_attached_file :data
end
