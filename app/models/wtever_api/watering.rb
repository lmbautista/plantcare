# frozen_string_literal: true

module WteverApi
  class Watering < WteverApi::Base
    attributes :duration_unit,
               :duration_amount,
               :status,
               :programmed_at,
               :consumed_at,
               :water_pump_field

    DURATION_UNITS = [
      DURATION_IN_SECONDS = "seconds",
      DURATION_IN_MINUTES = "minutes"
    ].freeze

    FREQUENCY_UNITS = [
      FREQUENCY_HOURS = "hours",
      FREQUENCY_DAYS = "days"
    ].freeze

    def short_duration_unit
      case duration_unit
      when DURATION_IN_SECONDS then "s"
      when DURATION_IN_MINUTES then "m"
      else ""
      end
    end
  end
end
