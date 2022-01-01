# frozen_string_literal: true

require 'rails_helper'
require './lib/catalog/reader'

RSpec.describe Catalog::Reader do
  let(:reader) { described_class.new }

  before do
    reader.collect_entities_from_input_files
  end

  it 'is able to load and parse pilots input files' do
    expect(reader.input_pilots.length).to be > 10
  end

  it 'is able to load and parse upgrades input files' do
    expect(reader.input_upgrades.length).to be > 10
  end

  it 'is able to load and parse actions input files' do
    expect(reader.input_actions.length).to be > 10
  end

  it 'is able to load and parse quick_builds input files' do
    expect(reader.input_quick_builds.length).to be > 10
  end

  it 'is able to load and parse factions input files' do
    expect(reader.input_factions.length).to be > 5
  end
end
