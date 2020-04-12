# frozen_string_literal: true

module PlantcaresHelper
  def plantcare_picture(plantcare)
    if plantcare.picture
      plantcare.picture
    else
      i = plantcare.id.to_i % 6
      image_url("plantcares/plantcare-default0#{i}.jpg")
    end
  end

  def plantcare_background(plantcare)
    if plantcare.picture
      "background-image: url('#{asset_path(plantcare.picture)}')"
    else
      i = plantcare.id.to_i % 6
      "background-image: url('#{image_url("plantcares/plantcare-default0#{i}.jpg")}')"
    end
  end

  def plantcare_status_icon(plantcare)
    case plantcare.status
    when "healthy"
      fa_icon "fal fa-thermometer-full vline-bottom"
    when "sick"
      fa_icon "fal fa-thermometer-half vline-bottom"
    when "lifeless"
      fa_icon "fal fa-thermometer-quarter vline-bottom"
    end
  end

  def plantcare_status_text(plantcare)
    case plantcare.status
    when "healthy"
      I18n.t("plantcares.status.healthy")
    when "sick"
      I18n.t("plantcares.status.sick")
    when "lifeless"
      I18n.t("plantcares.status.lifeless")
    end
  end

  def plantcare_wet(plantcare)
    number_to_percentage(plantcare.wet, strip_insignificant_zeros: true)
  end
end
