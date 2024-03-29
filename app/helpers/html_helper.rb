# frozen_string_literal: true

# Helpers to generate html code for views
module HtmlHelper
  # content: html content
  # title: text title
  # options:
  #   footer: false | true
  #   close_button: enables close button to dismiss modal
  #   form_id: form id to enable submit button in modal footer
  #   footer_buttons: array of buttons for footer (submit form, clear fields...): You can set ids
  #   and class for each button
  #
  #   Example: [{text: 'text_button', class: 'class_button', id: 'id_button'}]
  # rubocop:disable Metrics/PerceivedComplexity, Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/AbcSize,  Rails/OutputSafety
  def modal_for(modal_id, title, options = {})
    footer = ""
    header = ""
    if options[:footer] || options[:footer].nil?
      footer = "<div class=\"modal-footer\">"
      if options[:form_id].present?
        footer +=
          "<button type=\"button\" class=\"btn btn-primary\" "\
          "onClick=\"$('#{options[:form_id]}').submit();$('##{modal_id}').modal('toggle');\">"\
          "#{I18n.t("buttons.submit")}</button>"
      end
      if options[:close_button].present? && options[:close_button]
        footer += "<button type=\"button\" class=\"btn btn-danger\" data-dismiss=\"modal\">"\
                  "#{I18n.t("buttons.close")}</button>"
      end

      if options[:footer_buttons].present?
        options[:footer_buttons].each do |button|
          next if options[:footer_button].blank?

          footer += "<button type=\"button\" id=\"#{button[:id] if button.key?(:id)}\" "\
                    "class=\"btn btn-default #{button[:class] if button.key?(:class)}\ "\
                    "data-dismiss=\"modal\">#{button[:text] if button.key?(:text)}</button>"
        end
      end

      footer += "</div>"
    end

    if options.fetch(:header, true)
      header = "
      <div class=\"modal-header\">
        <h4 class=\"modal-title text-center\">#{title}</h4>
        <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\">
          #{fa_icon "font-color far fa-times-circle"}
        </button>
      </div>
      "
    end

    "<div id=\"#{modal_id}\" class=\"modal fade\" role=\"dialog\">
      <div class=\"modal-dialog\">
        <!-- Modal content-->
        <div class=\"modal-content\">
          #{header}
          <div class=\"modal-body\">
            #{yield}
          </div>
          #{footer}
        </div>
      </div>
    </div>".html_safe
  end
  # rubocop:enable Metrics/PerceivedComplexity, Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/AbcSize,  Rails/OutputSafety

  def fa_icon(classes)
    tag.i(nil, class: classes)
  end

  def model_name(instance, attribute)
    klass_name = instance.class.name.demodulize.pluralize.downcase
    I18n.t("#{klass_name}.plantcare_api.attributes.#{attribute}")
  end

  def label_for(instance, attribute, options = {})
    label_tag(attribute, model_name(instance, attribute), options)
  end

  def datepickerfield_for(form_helper, attribute)
    datepicker_id = SecureRandom.hex(4)
    tag.div(class: "input-group") do
      safe_join(
        [tag.span(
          fa_icon("fal fa-calendar-alt"),
          class: "input-group-addon",
          onclick: "$('[data-id=\"#{datepicker_id}\"]').trigger('focus')"
        ), form_helper.text_field(attribute,
                                  "class" => "form-control datepicker",
                                  "data-id" => datepicker_id)]
      )
    end
  end

  def connection_tag_for(board_connection_at)
    last_connection_status_class = last_connection_status_class(board_connection_at)

    fa_icon "fas fa-wifi opposite-color pl-1 bigger-1 vline-middle #{last_connection_status_class}"
  end

  def switch_for(form_instance, attribute, options = {})
    tag.div(class: options[:class].to_s) do
      tag.label(class: "switch vline-middle") do
        concat(form_instance.check_box(attribute))
        concat(tag.span(nil, class: "slider round"))
      end
    end
  end

  def circular_chart(value, options = {}, &block)
    tag.svg(viewBox: "0 0 36 36", class: "circular-chart #{options[:class]}") do
      safe_join(
        [
          tag.path(nil, "class" => "circle #{options[:status_class]}",
                        "stroke-dasharray" => "#{value}, 100",
                        "d" => "M18 2.0845 "\
                               "a 15.9155 15.9155 0 0 1 0 31.831"\
                               "a 15.9155 15.9155 0 0 1 0 -31.831"),
          tag.text(class: "percentage", x: "18", y: "21.35", &block)
        ]
      )
    end
  end

  def flex_image_div(image_url:, classes: nil, styles: nil, mobile: false)
    styles = [
      styles,
      "flex: 1",
      "background: url('#{asset_path(image_url)}') no-repeat center center",
      "background-size: contain",
      "margin: 10px",
      (mobile ? "height: 35vh" : "height: 55vh")
    ].compact.join(";")

    raw tag.div(class: classes, style: styles) { yield if defined?(yield) }
  end

  def flex_panel_div(classes: nil, mobile: false)
    styles = [
      "flex: 1",
      "display: flex",
      "justify-content: center",
      "align-items: center",
      (mobile ? "min-height: 40vh" : "min-height: 90vh")
    ].compact.join(";")

    raw tag.div(class: classes, style: styles) { yield if defined?(yield) }
  end

  def svg_icon_tag(name, options = {})
    options[:title] ||= name.underscore.humanize
    options[:aria] = true
    options[:nocomment] = true
    options[:variant] ||= :outline
    options[:class] = options.fetch(:classes, nil)
    icon = options.fetch(:path, "icons/#{name}.svg")

    inline_svg_tag(icon, options)
  end

  def board_status_tag(value)
    color = case value
            when "wet_sensor_error"
              "label-warning"
            when "server_error"
              "label-danger"
            else
              "label-success"
            end

    content = tag.span(class: "label #{color}") do
      I18n.t("plantcares.plantcare_api.boards.status.#{value}")
    end

    raw content
  end

  def watering_status_tag(value)
    color = case value
            when "programmed"
              "label-default"
            when "done"
              "label-success"
            else
              "label-default"
            end

    content = tag.span(class: "label #{color}") do
      I18n.t("plantcares.plantcare_api.waterings.status.#{value}")
    end

    raw content
  end
end
