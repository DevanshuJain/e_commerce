# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end


  # def create
  #   user = User.find_by_email(sign_in_params[:email])
  #     if user && user.valid_password?(sign_in_params[:password])
  #     @current_user = user
  #   else
  #     render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
  #   end
  # end



  def after_sign_in_path_for(resource)
    products_path
  end
end
