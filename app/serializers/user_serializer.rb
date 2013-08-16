class UserSerializer < ActiveModel::Serializer
  attributes :id,
    :email,
    :authentication_token,
    :role,
    :first_name,
    :last_name,
    :organization

  def organization
    object.organization.name if object.organization
  end
end