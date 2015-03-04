class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)
    if resource.save
      sign_up(resource_name, resource)
      render json: resource.as_json, status: 201
    else
      clean_up_passwords resource
      render json: {errors: resource.errors}, status: 422
    end
  end

  private

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end
end
