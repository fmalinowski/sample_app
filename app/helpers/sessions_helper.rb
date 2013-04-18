module SessionsHelper
  
  def sign_in(user)
    
    cookies.permanent[:remember_token] = user.remember_token #Save the cookie for 20 years from now
    self.current_user = user #self is used to avoid creating just a local variable (make current_user available in both controllers and views)
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  
end