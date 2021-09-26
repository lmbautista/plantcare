# Application helper
module ApplicationHelper
  include HtmlHelper

  def current_user
    Rails.cache.fetch("current_user_#{session[:current_user_id]}") do
      request.env['warden'].user
    end
  end

  def logged?
    session[:current_user_id]
  end

  def prepare_growl_message
    if flash[:error].present?
      "  $.growl.error({ message: '#{flash[:error]}', duration: 10000, title: 'Plantcare says:' });"
    elsif flash[:notice].present?
      "  $.growl.notice({ message: '#{flash[:notice]}', duration: 10000, title: 'Plantcare says:' });"
    elsif flash[:warning].present?
      "  $.growl.warning({ message: '#{flash[:warning]}', duration: 10000, title: 'Plantcare says:' });"
    else
      ""
    end
  end

  def growl_message
    growl_message = prepare_growl_message
    return if growl_message.blank?

    "<script type=\"text/javascript\"#{growl_message}</script>".html_safe
  end
end
