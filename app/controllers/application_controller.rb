class ApplicationController < ActionController::Base
  before_action :authenticate_user!,if: :use_before_action?
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # 条件チェック用のメソッド
  def use_before_action?
    true
  end
  
  protected
  #ストロングパラメーター
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
