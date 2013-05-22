class Media < ActiveRecord::Base
  include Trashable

  belongs_to :user
  validates :name, :presence => true
end
