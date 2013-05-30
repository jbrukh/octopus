class Experiment < ActiveRecord::Base
  strip_attributes :allow_empty => true, :only => [:name]

  belongs_to :media, polymorphic: true
  belongs_to :user

  validates :name, :presence => true
end
