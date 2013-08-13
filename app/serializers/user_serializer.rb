class UserSerializer < ActiveModel::Serializer
  attributes :id,
    :email,
    :authentication_token,
    :role,
    :first_name,
    :last_name
end