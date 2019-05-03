# frozen_string_literal: true

# ERM wet sensor model
require "her/file_upload"

module WteverApi
  class WetSensor < WteverApi::Base
    attributes :name,
               :status

    belongs_to :plantcare
  end
end
