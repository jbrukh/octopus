class ResultSerializer < ActiveModel::Serializer
  attributes :id,
    :data_file_name,
    :data_content_type,
    :data_file_size,
    :data_updated_at,
    :data_url

  def data_url
    object.data.expiring_url(10)
  end
end
