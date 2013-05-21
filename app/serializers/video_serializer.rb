class VideoSerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :description,
    :created_at,
    :updated_at,
    :owner,
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
end