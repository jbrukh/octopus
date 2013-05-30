class Tagging < ActiveRecord::Base
  strip_attributes :allow_empty => true, :only => [:name]

  belongs_to :user
  belongs_to :recording
end
