class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper #We include the sessionsHelper to have access to the sessions not only in views but also in all the controllers
  
  #Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end
end
