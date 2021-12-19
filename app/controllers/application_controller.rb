class ApplicationController < ActionController::Base
  
  def after_sign_in_path_for(resource)
    case resource
    when Customer
      root_path
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
    
  end
  
end
