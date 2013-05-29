class RecordingSerializer < ActiveModel::Serializer
  embed :ids, :include => true

  attributes :id,
    :created_at,
    :session_id,
    :state,
    :duration_ms,
    :owner,
    :name,
    :description,
    :data_file_name,
    :data_content_type,
    :data_file_size,
    :data_updated_at,
    :data_url

  def owner
    object.user.email
  end

  def data_url
    object.data.url
  end

  has_one :participant
end
