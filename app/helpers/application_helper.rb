# frozen_string_literal: true

# Application helper
module ApplicationHelper
  include HtmlHelper

  def current_user
    Rails.cache.fetch("current_user_#{session[:current_user_id]}") do
      request.env["warden"].user
    end
  end

  def logged?
    session[:current_user_id]
  end

  def prepare_growl_message
    if flash[:error].present?
      "  $.growl.error({ message: '#{flash[:error]}', duration: 6000, "\
        "title: '#{I18n.t("flash_message.error")}' });"
    elsif flash[:notice].present?
      "  $.growl.notice({ message: '#{flash[:notice]}', duration: 3000, "\
        "title: '#{I18n.t("flash_message.notice")}' });"
    elsif flash[:warning].present?
      "  $.growl.warning({ message: '#{flash[:warning]}', duration: 4000, "\
        "title: '#{I18n.t("flash_message.warning")}' });"
    else
      ""
    end
  end

  def growl_message
    growl_message = prepare_growl_message
    return if growl_message.blank?

    ["<script type=\"text/javascript\">",
     "$(document).ready(function(){",
     growl_message,
     "});",
     "</script>"].join(" ").html_safe # rubocop:disable Rails/OutputSafety
  end
end
