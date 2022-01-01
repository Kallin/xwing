# frozen_string_literal: true

require 'rails_helper'
require './lib/catalog/importer'

RSpec.describe Catalog::Importer do
  let(:importer) { described_class.new }

  let(:input_ships) do
    [
      {
        name: 'ship1',
        factions: %w[faction1 faction2]
      },
      {
        name: 'ship2',
        factions: ['faction1']
      }
    ]
  end

  let(:input_pilots) do
    [
      {
        name: 'pilot1',
        ship: 'ship1'
      },
      {
        name: 'pilot2',
        ship: 'ship1'
      },
      {
        name: 'pilot3',
        ship: 'ship2'
      }
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
    importer.input_factions = input_factions
    importer.input_pilots = input_pilots
    importer.import_all
  end

  it 'is able to import ships' do
    expect(Ship.count).to be == 2
  end

  it 'is able to import actions' do
    expect(Action.count).to be == 2
  end

  it 'is able to import factions' do
    expect(Faction.count).to be == 2
  end

  it 'is able to import pilots' do
    expect(Pilot.count).to be == 3
  end
end
