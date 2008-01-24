# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_wrct_session_id'
  
  layout 'application'
  
  def permission_granted
    logger.info("[authentication] Permission granted to %s at %s for %s" %
      [(logged_in? ? current_user.login : 'guest'), Time.now, request.request_uri])
  end
  
  def permission_denied
    logger.info("[authentication] Permission denied to %s at %s for %s" %
      [(logged_in? ? current_user.login : 'guest'), Time.now, request.request_uri])
    flash[:notice] = "Access Denied, yo"
    flash[:access_denied] = true
    redirect_to login_url
  end

end
