class RecordingSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :state
end
