class ApplicationController < ActionController::Base
  
  protect_from_forgery
  
  # before_action :redirect_to_log_in
  before_action :authenticate_admin!, if: proc { request.path.start_with?("/admin") }
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  private
  
  def after_sign_in_path_for(resource)
    case resource
    when Customer
      customer_mypage_path
    when Admin
      admin_root_path
    end
  end
  
  def after_sign_out_path_for(resource_or_scope)

    # logger.debug "クラス #{resource_or_scope.class},タイプ #{resource_or_scope}"
    
    if resource_or_scope == :customer
      root_path
    elsif resource_or_scope == :admin
      new_admin_session_path
    end
  end
  
  def after_sign_up_path_for(resource)
    customer_mypage_path
  end
  
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana \
                                                      ,:postal_code, :telephone_number, :address])
  end
  
  
  
end
