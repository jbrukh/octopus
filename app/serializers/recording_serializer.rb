class RecordingSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :state, :result_id, :duration_ms
  has_one :result
end
