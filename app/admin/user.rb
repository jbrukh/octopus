ActiveAdmin.register User do
  index do
    column :email
    column :last_name
    column :first_name
    column :role
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    column :organization
    default_actions
  end

  filter :email
  filter :role
  filter :organization

  form do |f|
    f.inputs "User Details" do
      f.input :first_name
      f.input :last_name
      f.input :role
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :organization
    end
    f.actions
  end

  controller do
    def update_resource(object, attributes)
      update_method = attributes.first[:password].present? ? :update_attributes : :update_without_password
      object.send(update_method, *attributes)
    end

    def permitted_params
      params.permit user: [
        :first_name,
        :last_name,
        :email,
        :password,
        :password_confirmation,
        :role,
        :organization_id
      ]
    end
  end
end
