# frozen_string_literal: true

# ERM plantcare model
require "her/file_upload"

module PlantcareApi
  class Plantcare < PlantcareApi::Base
    include Her::FileUpload

    WET_SENSOR_ARDUINO_FIELDS = {
      "SENSOR 1" => "A0",
      "SENSOR 2" => "A1",
      "SENSOR 3" => "A2",
      "SENSOR 4" => "A3",
      "SENSOR 5" => "A4",
      "SENSOR 6" => "A5"
    }.freeze

    KINDS = [
      SINGLE_KIND = "single",
      MULTIPLEX_KIND = "multiplex"
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
               :wet_synced_at,
               :water_pump_field,
               :water_pump_id,
               :board_sleep_time,
               :board_watering_interval,
               :board_watering_interval_delay,
               :calibrate_board,
               :configure_board

    has_one :board
    has_one :water_pump
    has_one :watering_schedule
    has_many :waterings

    delegate :auth_token,
             to: :board,
             prefix: true

    def wet
      super || 0.0
    end

    def status
      BigDecimal(wet.to_s) == BigDecimal("0.0") ? "non_data" : super
    end

    def single?
      kind == SINGLE_KIND
    end

    def multiplex?
      kind == MULTIPLEX_KIND
    end
  end
end
