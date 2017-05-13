module ApplicationHelper
  def current_user
    env['warden'].user
  end

  def logged
    current_user.present?
  end

  def growl_message
    growl_message = if flash[:error].present?
                      "  $.growl.error({ message: '#{flash[:error]}', duration: 10000, title: 'Plantcare says:' });"
                    elsif flash[:notice].present?
                      "  $.growl.notice({ message: '#{flash[:notice]}', duration: 10000, title: 'Plantcare says:' });"
                    elsif flash[:warning].present?
                      "  $.growl.warning({ message: '#{flash[:warning]}', duration: 10000, title: 'Plantcare says:' });"
                    else
                      ""
                    end

    return unless growl_message.present?

    errors = '<script type="text/javascript">'
    errors << growl_message
    errors << '</script>'
    raw errors
  end
end
