# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  #protect_from_forgery :secret => 'b0a876313f3f9195e9bd01473bc5cd06'
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  filter_parameter_logging :password, :password_confirmation

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  private

  def authorize
    @current_user = User.find_by_id(session[:user_id])
    unless @current_user
      flash[:notice] = "Lütfen sisteme giriş yapınız."
      redirect_to(:controller => "welcome", :action => "login")
    end
  end

  def authorize_admin
    @current_user = User.find_by_id(session[:user_id])
    unless @current_user.user_type.name == "Admin"
      flash[:notice] = "Bu işlem için Yönetici olmanız gerekmektedir."
      redirect_to(:controller => "welcome", :action => "login")
    end
  end

  protected

  # Automatically respond with 404 for ActiveRecord::RecordNotFound
  def record_not_found
    render :file => File.join(RAILS_ROOT, 'public', '404.html'), :status => 404
  end
end
