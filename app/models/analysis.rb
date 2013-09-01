class Analysis < ActiveRecord::Base
  belongs_to :user
  belongs_to :recording

  validates :jid,       :presence => true
  validates :algorithm, :presence => true
  validates :state,     :presence => true

  state_machine :state, :initial => :processing do
    after_transition :on => :processed, :do => :save!

    event :completed do
      transition :processing => :processed
    end
  end
end
