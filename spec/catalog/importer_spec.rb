# frozen_string_literal: true

require 'rails_helper'
require './lib/catalog/importer'

RSpec.describe Catalog::Importer do
  let(:importer) { described_class.new }

  let(:input_ships) do
    [
      { name: 'ship1' },
      { name: 'ship2' }
    ]
  end

  let(:input_actions) do
    [
      { name: 'action1' },
      { name: 'action2' }
    ]
  end

  let(:input_factions) do
    [
      { name: 'faction1' },
      { name: 'faction2' }
    ]
  end

  before do
    importer.input_ships = input_ships
    importer.input_actions = input_actions
    importer.input_factions = input_actions
  end

  it 'is able to import ships' do
    importer.import_ships
    expect(Ship.count).to be == 2
  end

  it 'is able to import actions' do
    importer.import_actions
    expect(Action.count).to be == 2
  end

  it 'is able to import factions' do
    importer.import_factions
    expect(Faction.count).to be == 2
  end
end
