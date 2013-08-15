class Organization < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'

  validates :name,  :presence => true

  strip_attributes :allow_empty => true, :only => [:name]
end
