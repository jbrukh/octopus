class ResultSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at,
    :data_file_name, :data_content_type, :data_file_size, :data_updated_at, :data_url

  def data_url
    object.data.url
  end
end
