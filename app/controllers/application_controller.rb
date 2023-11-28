# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticator
  before_action :set_user_api_token, if: :logged?
  before_action :set_locale

  rescue_from PlantcareApi::ForbiddenError,      with: :forbidden
  rescue_from PlantcareApi::NotFoundError,       with: :not_found
  rescue_from PlantcareApi::InternalServerError, with: :internal_server_error

  protected

  def authenticator
    redirect_to root_path unless logged?
  end

  def set_user_api_token
    RequestStore.store[:wtever_token] ||= session[:api_token]
  end

  def set_locale
    I18n.locale = (session[:lang].presence || I18n.default_locale) if current_user.present?
  end

  def to_flash(errors)
    html_errors = errors.map do |model, attributes|
      attributes.map do |name, descriptions|
        "#{model}_#{name}: #{descriptions.map(&:humanize).join(", ")}"
      end
    end
    html_errors.join("<br/>")
  end

  def unauthorized
    flash[:error] = I18n.t("errors.unauthorized")
    redirect_to root_path
  end

  def forbidden
    flash[:error] = I18n.t("errors.forbidden")
    redirect_to root_path
  end

  def not_found # rubocop:disable Naming/PredicateName
    flash[:error] = I18n.t("errors.not_found")
    redirect_to root_path
  end

  def internal_server_error
    flash[:error] = I18n.t("errors.internal_server_error")
    redirect_to root_path
  end
end
