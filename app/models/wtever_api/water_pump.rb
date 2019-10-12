# frozen_string_literal: true

# ERM plantcare model
require "her/file_upload"

module WteverApi
  class WaterPump < WteverApi::Base
    include Her::FileUpload

    attributes :status,
               :water_for

    ENABLED_STATUSES = [
      ENABLED = "enabled",
      DISABLED = "disabled"
    ].freeze

    ARDUINO_FIELDS = [
      FIELD_IN1 = "IN1",
      FIELD_IN2 = "IN2",
      FIELD_IN3 = "IN3",
      FIELD_IN4 = "IN4",
      FIELD_IN5 = "IN5",
      FIELD_IN6 = "IN6",
      FIELD_IN7 = "IN7",
      FIELD_IN8 = "IN8"
    ].freeze

    def status_to_attribute
      status == 1 ? ENABLED : DISABLED
    end

    def attributes
      byebug
      super.merge!(status: status_to_attribute)
    end
  end
end
