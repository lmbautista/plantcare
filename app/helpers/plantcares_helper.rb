# frozen_string_literal: true

module PlantcaresHelper
  def plantcare_picture(plantcare)
    if plantcare.picture
      plantcare.picture
    else
      i = plantcare.id.to_i % 6 +1
      image_url("plantcares/plantcare-default0#{i}.jpg")
    end
  end

  def plantcare_background(plantcare)
    if plantcare.picture
      "background-image: url('#{asset_path(plantcare.picture)}')"
    else
      i = plantcare.id.to_i % 6 + 1
      "background-image: url('#{image_url("plantcares/plantcare-default0#{i}.jpg")}')"
    end
  end

  def plantcare_wet(plantcare)
    number_to_percentage(plantcare.wet, strip_insignificant_zeros: true)
  end

  def wet_sensors_collection
    WteverApi::Plantcare::WET_SENSOR_ARDUINO_FIELDS.to_a
  end

  def water_pumps_collection
    WteverApi::WaterPump::ARDUINO_FIELDS.to_a
  end

  def countries_collection
    WteverApi::Country.all.map { |country| [country.name.humanize, country.code] }
  end

  def timezones_collection
    ActiveSupport::TimeZone.all.map(&:name)
  end

  def lang_collection
    [
      ["🇪🇸", :es],
      ["🇬🇧", :en]
    ]
  end

  def last_connection_status_class(board_connection_at)
    return "connection-non-data" if board_connection_at.blank?

    healthy_check_offset = Time.current - board_connection_at

    return "connection-less-than-5" if healthy_check_offset < 5.minutes
    return "connection-less-than-10" if healthy_check_offset < 10.minutes
    return "connection-less-than-15" if healthy_check_offset < 15.minutes

    "connection-less-than-20"
  end

  def last_connection_tag(board_connection_at)
    board_connection_at_copy =
      board_connection_at.present? ? I18n.localize(board_connection_at) : "-"

    I18n.t("menu.status_explanation", board_connection_at: board_connection_at_copy)
  end
end
