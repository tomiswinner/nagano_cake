class ApplicationController < ActionController::Base
  
  def after_sign_out_path_for(scope)
    new_admin_session_path
  end
  
end
