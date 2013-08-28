ActiveAdmin.register Recording do
  controller do
    def permitted_params
      params.permit recording: [
        :duration_ms
      ]
    end
  end
end
