module PlantcaresHelper

  def plantcare_picture(plantcare)
    i = rand(1..6)
    "background-image: url('#{image_url("plantcares/plantcare-default0#{i}.jpg")}')"
  end
end
