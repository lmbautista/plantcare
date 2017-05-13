class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_user_api_token
  rescue_from Her::Errors::ResourceInvalid, with: :resource_invalid_error

  protected
    def set_user_api_token
      RequestStore.store[:wtever_token] = current_user.api_token if logged # or something similar based on `session`
    end

    def to_flash(errors)
      errors.collect{|key,value| "#{key.to_s.humanize}: #{value.join("; ").humanize}" }.join("<br/>").html_safe
    end
end
