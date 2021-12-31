# frozen_string_literal: true

require 'rails_helper'
require './lib/catalog/reader'

RSpec.describe Catalog::Loader do
  let(:loader) { described_class.new }

  before do
    loader.collect_entities_from_input_files
  end

  it 'is able to load and parse pilots input files' do
    expect(loader.input_pilots.length).to be > 10
  end

  it 'is able to load and parse upgrades input files' do
    expect(loader.input_upgrades.length).to be > 10
  end

  it 'is able to load and parse actions input files' do
    expect(loader.input_actions.length).to be > 10
  end

  it 'is able to load and parse quick_builds input files' do
    expect(loader.input_quick_builds.length).to be > 10
  end

  it 'is able to load and parse factions input files' do
    expect(loader.input_factions.length).to be > 5
  end
end
