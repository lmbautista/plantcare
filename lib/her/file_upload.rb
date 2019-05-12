# frozen_string_literal: true

module Her
  module FileUpload
    extend ActiveSupport::Concern

    module ClassMethods
      def file_upload(attribute)
        attributes attribute

        define_method(:"#{ attribute }=") do |files|
          assign_file_attribute(attribute.to_sym, files)
        end
      end
    end

    def assign_file_attribute(attribute, files)
      return if files.blank?

      files = Array(files).map {|file| generate_faraday_upload_io(file) }

      # Super can't be called with Stack Level Too Deep errors
      send(:"#{ attribute }_will_change!") if @attributes[attribute] != files

      @attributes[attribute] = files.size > 1 ? files : files.first
    end

    def generate_faraday_upload_io(file)
      return file unless file.is_a?(ActionDispatch::Http::UploadedFile)

      Faraday::UploadIO.new(
        file.tempfile.path,
        file.content_type,
        file.original_filename
      )
    end
  end
end
