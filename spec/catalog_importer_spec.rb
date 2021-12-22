require 'rails_helper'
require './lib/catalog_importer'

RSpec.describe CatalogImporter do

  it 'is able to load and parse all input files' do
    importer = CatalogImporter.new

    importer.collect_entities_from_input_files

    expect(importer.input_pilots.length).to be > 10 #and count > 10
    expect(importer.input_upgrades.length).to be > 10 #and count > 10
    expect(importer.input_actions.length).to be > 10 #and count > 10
    expect(importer.input_quick_builds.length).to be > 10 #and count > 10
  end

end