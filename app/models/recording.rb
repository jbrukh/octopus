class Recording < ActiveRecord::Base
  belongs_to :user
  belongs_to :result

  state_machine :state, :initial => :waiting_for_data do
  end
end
