# frozen_string_literal: true

module PlantcareApi
  class Watering < PlantcareApi::Base
    attributes :duration_unit,
               :duration_amount,
               :status,
               :programmed_at,
               :consumed_at,
               :water_pump_field,
               :water_pump_id,
               :watering_schedule_id

    DURATION_UNITS = [
      DURATION_IN_SECONDS = "seconds",
      DURATION_IN_MINUTES = "minutes"
    ].freeze

    FREQUENCY_UNITS = [
      FREQUENCY_HOURS = "hours",
      FREQUENCY_DAYS = "days"
    ].freeze

    STATUS_PROGRAMMED = "programmed"
    STATUS_DONE = "done"

    def short_duration_unit
      case duration_unit
      when DURATION_IN_SECONDS then "s"
      when DURATION_IN_MINUTES then "m"
      else ""
      end
    end

    def programmed?
      status == STATUS_PROGRAMMED
    end
  end
end
