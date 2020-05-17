# frozen_string_literal: true

module WteverApi
  class WateringSchedule < WteverApi::Base
    attributes :starts_on,
               :ends_on,
               :status,
               :duration_unit,
               :duration_amount,
               :frequency_unit,
               :frequency_amount,
               :plantcare_id

    DURATION_UNITS = [
      DURATION_IN_SECONDS = "seconds",
      DURATION_IN_MINUTES = "minutes"
    ].freeze

    FREQUENCY_UNITS = [
      FREQUENCY_HOURS = "hours",
      FREQUENCY_DAYS = "days"
    ].freeze
  end
end