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
end
