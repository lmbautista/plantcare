# frozen_string_literal: true

# Helpers to generate html code for views
module HtmlHelper
  # content: html content
  # title: text title
  # options:
  #   footer: false | true
  #   close_button: enables close button to dismiss modal
  #   form_id: form id to enable submit button in modal footer
  #   footer_buttons: array of buttons for footer (submit form, clear fields...): You can set ids
  #   and class for each button
  #
  #   Example: [{text: 'text_button', class: 'class_button', id: 'id_button'}]
  def modal_for(modal_id, title, options = {})
    footer = ""
    header = ""
    if options[:footer] || options[:footer].nil?
      footer = "<div class=\"modal-footer\">"
      footer += "<button type=\"button\" class=\"btn btn-primary\" onClick=\"$('#{options[:form_id]}').submit();$('##{modal_id}').modal('toggle');\">#{I18n.t('buttons.submit')}</button>" if options[:form_id].present?
      footer += "<button type=\"button\" class=\"btn btn-danger\" data-dismiss=\"modal\">#{I18n.t('buttons.close')}</button>" if options[:close_button].present? && options[:close_button]

      if options[:footer_buttons].present?
        options[:footer_buttons].each do |button|
          footer += "<button type=\"button\" id=\"#{button[:id] if button.key?(:id)}\" class=\"btn btn-default #{button[:class] if button.key?(:class)}\ data-dismiss=\"modal\">#{button[:text] if button.key?(:text)}</button>" if options[:footer_button].present?
        end
      end

      footer += "</div>"
    end

    if options.fetch(:header, true)
      header = "
      <div class=\"modal-header\">
        <h4 class=\"modal-title\">#{title}</h4>
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

  def fa_icon(classes)
    content_tag(:i, nil, class: classes)
  end

  def model_name(instance, attribute)
    klass_name = instance.class.name.demodulize.pluralize.downcase
    I18n.t("#{klass_name}.wtever_api.attributes.#{attribute}")
  end

  def label_for(instance, attribute, options = {})
    label_tag(attribute, model_name(instance, attribute), options)
  end

  def datepickerfield_for(form_helper, attribute)
    datepicker_id = SecureRandom.hex(4)
    content_tag(:div, class: "input-group") do
      safe_join(
        [content_tag(
          :span,
          fa_icon("fal fa-calendar-alt"),
          class: "input-group-addon", onclick: "$('[data-id=\"#{datepicker_id}\"]').trigger('focus')"
        ),
         form_helper.text_field(attribute, "class" => "form-control datepicker", "data-id" => datepicker_id)]
      )
    end
  end

  def switch_for(form_instance, attribute, options = {})
    content_tag :div, class: options[:class].to_s do
      content_tag :label, class: "switch" do
        concat(form_instance.check_box(attribute))
        concat(content_tag(:span, nil, class: "slider round"))
      end
    end
  end

  def circular_chart(value, options = {})
    content_tag :svg, viewBox: "0 0 36 36", class: "circular-chart" do
      safe_join(
        [
          content_tag(:path,
                      nil,
                      "class" => "circle #{options[:class]}",
                      "stroke-dasharray" => "#{value}, 100",
                      "d" => "M18 2.0845 "\
                            "a 15.9155 15.9155 0 0 1 0 31.831"\
                            "a 15.9155 15.9155 0 0 1 0 -31.831"),
          content_tag(:text, class: "percentage", x: "18", y: "21.35") do
            yield
          end
        ]
      )
    end
  end
end
