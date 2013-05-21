class ExperimentSerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :description,
    :created_at,
    :updated_at,
    :owner

  def owner
    object.user.email
  end
end
