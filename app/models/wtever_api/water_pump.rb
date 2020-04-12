# frozen_string_literal: true

module WteverApi
  class WaterPump < WteverApi::Base
    attributes :status,
               :water_for

    STATUSES = {
      "1" => "enabled",
      "0" => "disabled"
    }.freeze

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

    def status
      STATUSES.key(super) || super
    end

    def attributes
      super.merge(status: STATUSES[status])
    end
  end
end
