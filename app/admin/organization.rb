ActiveAdmin.register Organization do
  index do
    column :name
    default_actions
  end

  filter :name

  controller do
    def permitted_params
      params.permit organization: [
        :name
      ]
    end
  end
end
