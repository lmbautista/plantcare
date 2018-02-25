require 'her/file_upload'

module WteverApi
  class Plantcare < WteverApi::Base
    include Her::FileUpload

    has_file_upload :attachments

    attributes :name, :kind, :planted_at, :watered_at, :wet, :status, :attachments
  end
end
