class ApplicationController < ActionController::Base
  include Clearance::Authentication
  protect_from_forgery
  before_filter :admin_user
  
  private
    def admin_user
      if current_user.nil? || !current_user.admin?
        redirect_to(root_path)
      end
    end
end
