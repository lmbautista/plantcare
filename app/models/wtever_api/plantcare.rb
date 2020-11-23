# frozen_string_literal: true

# ERM plantcare model
require "her/file_upload"

module WteverApi
  class Plantcare < WteverApi::Base
    include Her::FileUpload

    WET_SENSOR_ARDUINO_FIELDS = {
      "SENSOR 1" => "A0",
      "SENSOR 2" => "A1",
      "SENSOR 3" => "A2",
      "SENSOR 4" => "A3",
      "SENSOR 5" => "A4",
      "SENSOR 6" => "A5"
    }.freeze

    file_upload :attachments
    file_upload :picture

    attributes :name,
               :kind,
               :planted_at,
               :status,
               :wet,
               :wet_sensor_field,
               :watered_at,
               :water_pump_field,
               :water_pump_id

    has_one :water_pump
    has_one :watering_schedule
    has_many :waterings

    def wet
      super || 0.0
    end

    def status
      wet == 0.0 ? "non_data" : super
    end
  end
end
