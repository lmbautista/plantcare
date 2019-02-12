module PlantcaresHelper
  def plantcare_picture(plantcare)
    if plantcare.picture
      "background-image: url('#{asset_path(plantcare.picture)}')"
    else
      i = plantcare.id.to_i % 6
      "background-image: url('#{image_url("plantcares/plantcare-default0#{i}.jpg")}')"
    end
  end
end
