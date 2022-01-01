# frozen_string_literal: true

require './lib/catalog/importer'

desc 'manage the game catalog'

task refresh_all: :environment do
  importer = Catalog::Importer.new
  importer.refresh_all
end
