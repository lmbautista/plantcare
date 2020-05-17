# frozen_string_literal: true

# ERM plantcare model
require "her/file_upload"

module WteverApi
  class Plantcare < WteverApi::Base
    include Her::FileUpload

    WET_SENSOR_ARDUINO_FIELDS = [
      FIELD_A0 = "A0",
      FIELD_A1 = "A1",
      FIELD_A2 = "A2",
      FIELD_A3 = "A3",
      FIELD_A4 = "A4",
      FIELD_A5 = "A5"
    ].freeze

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
  end
end
