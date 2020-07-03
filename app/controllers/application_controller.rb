class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end
end

# deviseでは初期状態でサインアップ時にメールアドレスとパスワードのみを受け取るようにストロングパラメーターが設定してあるので、
# 追加したキー（nickname）のパラメーターは許可されていません。

# 追加のパラメーターを許可したい場合は、application_controller.rb
# においてbefore_actionにconfigure_permitted_parametersメソッドを設定します。