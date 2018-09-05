class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include DeviseTokenAuth::Concerns::SetUserByToken
  # def find_user_name
  #   if user_signed_in? 
  #     before_action :authenticate_user!
  #   else
  #     before_action :authenticate_seller!
  #   end
  # end
end
