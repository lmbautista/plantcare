# frozen_string_literal: true

# Helpers to generate html code for views
module HtmlHelper
  def fa_icon(classes)
    content_tag(:i, nil, class: classes)
  end

  def model_name(instance, attribute)
    klass_name = instance.class.name.demodulize.pluralize.downcase
    I18n.t("#{klass_name}.wtever_api.attributes.#{attribute}")
  end

  def label_for(instance, attribute)
    label_tag(attribute, model_name(instance, attribute))
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
end
