class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_locale

    def default_url_options
      {locale: I18n.locale}
    end


  private
  def set_locale
     I18n.locale = params[:locale] || I18n.default_locale

   end


   protected

  #configure permitted parameters for devise
  def configure_permitted_parameters
   added_attrs = [:email, :password, :password_confirmation, :remember_me,]
   devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  end
end
