class RecordingSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :state, :result_id, :duration_ms, :owner
  has_one :result

  def owner
    object.user.email
  end
end
