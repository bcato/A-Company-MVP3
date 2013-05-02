class ApplicationController < ActionController::Base
  protect_from_forgery

  def stored_location_for(resource)
  	nil
  end

  def after_sign_in_path_for(resource)
  	instruments_path
  end

  def after_edit_path_for(resource)
  	user_path(current_user)
  end


end
