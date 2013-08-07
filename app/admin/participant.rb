ActiveAdmin.register Participant do
  index do
    column :last_name
    column :first_name
    column :email
    column :gender
    column :birthday
    default_actions
  end

  filter :last_name
  filter :first_name
  filter :email
  filter :gender
  filter :birthday
end
