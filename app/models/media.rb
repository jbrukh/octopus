class Media < ActiveRecord::Base
  include Trashable

  strip_attributes :allow_empty => true, :only => [:name]

  belongs_to :user

  validates :name, :presence => true
end
