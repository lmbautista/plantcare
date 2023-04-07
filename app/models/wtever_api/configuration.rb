# frozen_string_literal: true

module WteverApi
  class Configuration < WteverApi::Base
    attributes :max_dried_value,
               :max_wet_value,
               :calculated_max_dried_value,
               :calculated_max_wet_value,
               :watering_interval,
               :watering_interval_delay,
               :auto_calculation,
               :sleep_time
  end
end
