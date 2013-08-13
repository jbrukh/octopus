ActiveAdmin.register User do
  index do
    column :email
    column :last_name
    column :first_name
    column :role
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  filter :email
  filter :role

  form do |f|
    f.inputs "Admin Details" do
      f.input :first_name
      f.input :last_name
      f.input :role
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit user: [
        :first_name,
        :last_name,
        :email,
        :password,
        :password_confirmation,
        :role
      ]
    end
  end
end
