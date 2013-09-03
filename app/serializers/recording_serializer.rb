class RecordingSerializer < ActiveModel::Serializer
  attributes :id,
    :created_at,
    :state,
    :duration_ms,
    :owner,
    :name,
    :description

  def owner
    object.user.email
  end

  has_one   :participant
  has_many  :taggings
  has_many  :analyses
end
