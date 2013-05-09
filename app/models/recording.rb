class Recording < ActiveRecord::Base
  belongs_to :user
  belongs_to :result

  state_machine :state, :initial => :waiting_for_data do
    after_transition :on => :uploaded, :do => :save!

    event :on_build_result do
      transition :waiting_for_data => :uploaded
    end
  end

  def upload(result_params)
    build_result(result_params).tap do |r|
      r.duration = 3000
      on_build_result
    end
  end
end
