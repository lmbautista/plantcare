# frozen_string_literal: true

# ERM plantcare model
require "her/file_upload"

module WteverApi
  class Plantcare < WteverApi::Base
    include Her::FileUpload

    file_upload :attachments
    file_upload :picture

    attributes :name,
               :kind,
               :planted_at,
               :wet,
               :status

    has_one :wet_sensor
  end
end
