class Recording < ActiveRecord::Base
  include Trashable
  include Viewable

  strip_attributes :allow_empty => true, :only => [:name]

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

  def upload(result_params)
    return false if self.uploaded?

    result_data = result_params[:data]

    if result_data
      self.data = result_data
    else
      self.data_file_name = result_params[:data_file_name]
      self.data_file_size = result_params[:data_file_size]
      self.data_content_type = result_params[:data_content_type]
    end

    self.duration_ms = result_params[:duration_ms]

    on_build_result

    true
  end

  def update_from_obf!(obf)
    self.duration_ms = obf.duration_ms
    self.save!
  end
end
