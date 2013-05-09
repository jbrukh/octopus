class RecordingSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :state, :result_id
  has_one :result
end
