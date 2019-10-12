# frozen_string_literal: true

# ERM plantcare model
require "her/file_upload"

module WteverApi
  class Plantcare < WteverApi::Base
    include Her::FileUpload

    file_upload :attachments
    file_upload :picture

    attributes :name,
               :kind,
               :planted_at,
               :wet,
               :status,
               :watered_at,
               :wet_sensor_field,
               :water_pump_field
  end
end
