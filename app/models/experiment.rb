class Experiment < ActiveRecord::Base
  belongs_to :media, polymorphic: true
  belongs_to :user

  validates :name, :presence => true
end
