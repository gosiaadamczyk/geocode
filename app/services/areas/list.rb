module Areas
  class List < BaseService
    def call
      JSON.parse(areas)
    end

    private

    def areas
      File.read(file_path)
    end

    def file_path
      Dir.glob("#{Rails.root}/data/areas/*.json").first
    end
  end
end
