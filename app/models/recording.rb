class Recording < ActiveRecord::Base
  include Trashable

  belongs_to :user
  belongs_to :participant
  has_many :taggings

  has_attached_file :data

  state_machine :state, :initial => :waiting_for_data do
    after_transition :on => :uploaded, :do => :save!

    event :on_build_result do
      transition :waiting_for_data => :uploaded
    end
  end

  def upload(result_params, session_id)
    if !self.session_id || self.session_id != session_id
      raise 'session_id_mismatch' # TODO do this properly
    end
    self.data = result_params[:data]
    on_build_result
  end

  def update_from_obf!(obf)
    self.duration_ms = obf.duration_ms
    self.save!
  end
end
