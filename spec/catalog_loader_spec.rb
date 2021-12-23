require 'rails_helper'
require './lib/catalog_loader'

RSpec.describe CatalogLoader do

  it 'is able to load and parse all input files' do
    loader = CatalogLoader.new

    loader.collect_entities_from_input_files

    expect(loader.input_pilots.length).to be > 10 #and count > 10
    expect(loader.input_upgrades.length).to be > 10 #and count > 10
    expect(loader.input_actions.length).to be > 10 #and count > 10
    expect(loader.input_quick_builds.length).to be > 10 #and count > 10
  end

end