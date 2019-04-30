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
      return unless files.present?

      files = files.collect { |file| generate_faraday_upload_io(file) }

      # Super can't be called with Stack Level Too Deep errors
      send(:"#{ attribute }_will_change!") if @attributes[attribute] != files

      @attributes[attribute] = files
    end

    def generate_faraday_upload_io(file)
      return unless file.is_a?(ActionDispatch::Http::UploadedFile)

      Faraday::UploadIO.new(
        file.tempfile.path,
        file.content_type,
        file.original_filename
      )
    end
  end
end
