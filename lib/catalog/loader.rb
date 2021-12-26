# frozen_string_literal: true

module Catalog
  class Loader
    attr_accessor :input_pilots, :input_upgrades, :input_actions, :input_quick_builds

    def collect_entities_from_input_files
      %w[pilots actions quick-builds upgrades].each do |entity_type|
        folder_path = build_catalog_path(entity_type)
        entity_type_underscored = entity_type.sub('-', '_')
        collect_entities_from_json(folder_path, entity_type_underscored)
      end

      # quick builds has a funny format
      @input_quick_builds = input_quick_builds.map { |it| it['quick-builds'] }.flatten
    end

    def collect_entities_from_json(path, entity_type)
      input_files = Dir["#{path}/**/*.json"]
      # a.send(:c=, b.send(:c))
      json_entities = input_files.map do |input_file|
        file_content = File.read(input_file)
        JSON.parse(file_content)
      end.flatten

      send "input_#{entity_type}=", json_entities
    end

    def build_catalog_path(folder)
      Rails.root.join('db', 'catalog', 'xwing-data2', folder)
    end
  end
end
