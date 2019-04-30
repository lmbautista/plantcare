require 'her/file_upload'

module WteverApi
  class Plantcare < WteverApi::Base
    include Her::FileUpload

    file_upload :attachments
    file_upload :picture

    attributes :name,
               :kind,
               :planted_at,
               :watered_at,
               :wet,
               :status,
               :picture,
               :attachments

  end
end
