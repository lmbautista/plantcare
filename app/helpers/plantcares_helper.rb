module PlantcaresHelper
  def plantcare_picture(plantcare)
    if plantcare.picture
      "background-image: url('#{image_url(plantcare.picture)}"
    else
      i = rand(1..6)
      "background-image: url('#{image_url("plantcares/plantcare-default0#{i}.jpg")}')"
    end
  end
end
