class Organization < ActiveRecord::Base
  validates :name,  :presence => true

  has_many :users

  strip_attributes :allow_empty => true, :only => [:name]
end
