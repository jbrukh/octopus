class Theory < ActiveRecord::Base
  belongs_to :media, polymorphic: true

  validates :name, :presence => true
end
