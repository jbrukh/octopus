class ParticipantSerializer < ActiveModel::Serializer
  attributes :id,
    :first_name,
    :last_name,
    :gender,
    :email,
    :birthday,
    :created_at,
    :updated_at
end
