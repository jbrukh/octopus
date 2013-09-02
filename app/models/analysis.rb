class Analysis < ActiveRecord::Base
  belongs_to :user
  belongs_to :recording

  validates :algorithm, :presence => true, :inclusion   => { :in => %w(fft) }
  validates :state,     :presence => true

  before_validation :initialize_arguments, :on => :create, :if => :can_initialize_arguments

  state_machine :state, :initial => :pending do
    after_transition :on => :dispatch,  :do => :save!
    after_transition :on => :completd,  :do => :save!

    event :on_dispatch do
      transition :pending => :processing
    end

    event :on_completed do
      transition :dispatched => :processed
    end
  end

  def dispatch!(jid)
    self.jid
    on_dispatch
    save!
  end

protected
  def can_initialize_arguments
    !self.recording.nil?
  end

  def initialize_arguments
    self.arguments = {
      :input_file => self.recording.data.expiring_url(10)
    }
  end
end
