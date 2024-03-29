class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :authenticate_admin!, if: :admin_url

  def admin_url
    request.fullpath.include?("/admin")
  end


  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_root_path
    when Customer
      root_path
    end
  end

#サインアップ後の遷移先を指定する方法

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
        new_admin_session_path
    else resource_or_scope == :customer
        root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :user_name])
  end

end
