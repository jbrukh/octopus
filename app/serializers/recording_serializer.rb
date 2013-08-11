class RecordingSerializer < ActiveModel::Serializer
  attributes :id,
    :created_at,
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

  has_one   :participant
  has_many  :taggings
end
