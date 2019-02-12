module ApplicationHelper
  def current_user
    RequestStore.store[:current_user] ||= Rails.cache.fetch("current_user_#{session[:current_user_id]}") do
      request.env['warden'].user
    end
  end

  def logged?
    current_user.present?
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

    return unless growl_message.present?

    errors = '<script type="text/javascript">'
    errors << growl_message
    errors << '</script>'
    raw errors
  end

  # content: html content
  # title: text title
  # options:
  #   footer: false | true
  #   close_button: enables close button to dismiss modal
  #   form_id: form id to enable submit button in modal footer
  #   footer_buttons: array of buttons for footer (submit form, clear fields...): You can set ids and class for each button
  #
  #   Example: [{text: 'text_button', class: 'class_button', id: 'id_button'}]

  def modal_for(modal_id, title, options = {})
    footer = ""

    if options[:footer] || options[:footer].nil?
      footer = "<div class=\"modal-footer\">"
      footer+= "<button type=\"button\" class=\"btn btn-primary\" onClick=\"$('#{options[:form_id]}').submit();$('##{modal_id}').modal('toggle');\">#{I18n.t("buttons.submit")}</button>" if options[:form_id].present?
      footer+= "<button type=\"button\" class=\"btn btn-danger\" data-dismiss=\"modal\">#{I18n.t("buttons.close")}</button>" if options[:close_button].present? && options[:close_button]

      if options[:footer_buttons].present?
        options[:footer_buttons].each do |button|
          footer+= "<button type=\"button\" id=\"#{button[:id] if button.has_key?(:id)}\" class=\"btn btn-default #{button[:class] if button.has_key?(:class)}\ data-dismiss=\"modal\">#{button[:text] if button.has_key?(:text)}</button>" if options[:footer_button].present?
        end
      end

      footer+="</div>"
    end

    "<div id=\"#{modal_id}\" class=\"modal fade\" role=\"dialog\">
      <div class=\"modal-dialog\">

        <!-- Modal content-->
        <div class=\"modal-content\">
          <div class=\"modal-header\">
            <h4 class=\"modal-title\">#{title}</h4>
          </div>
          <div class=\"modal-body\">
            #{yield}
          </div>
          #{footer}
        </div>

      </div>
    </div>".html_safe
  end

  def cssgramer
    filters = %w(_1977 aden brannan brooklyn clarendon earlybird gingham lark reyes rise slumber valencia)
    i = rand(1..15)
    filters[i]
  end
end
