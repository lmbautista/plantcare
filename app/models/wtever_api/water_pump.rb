# frozen_string_literal: true

module WteverApi
  class WaterPump < WteverApi::Base
    attributes :status,
               :water_for

    STATUSES = {
      "1" => "enabled",
      "0" => "disabled"
    }.freeze

    ARDUINO_FIELDS = {
      "BOMBA 1" => "IN1",
      "BOMBA 2" => "IN2",
      "BOMBA 3" => "IN3",
      "BOMBA 4" => "IN4",
      "BOMBA 5" => "IN5",
      "BOMBA 6" => "IN6",
      "BOMBA 7" => "IN7",
      "BOMBA 8" => "IN8"
    }.freeze

    def status
      STATUSES.key(super) || super
    end

    def attributes
      super.merge(status: STATUSES[status])
    end
  end
end
