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
        ship: 'ship1',
        xws_id: 'p1s1'
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

  let(:input_upgrade_types) do
    [
      { name: 'upgrade_type1' },
      { name: 'upgrade_type2' }
    ]
  end

  let(:input_upgrades) do
    [
      { name: 'upgrade1', upgrade_types: ['upgrade_type1'], xws_id: 'ug1' },
      { name: 'upgrade2', upgrade_types: %w[upgrade_type1 upgrade_type2], xws_id: 'ug2' }
    ]
  end

  let(:input_quick_builds) do
    [
      { pilot: 'p1s1', upgrades: %w[ug1 ug2] }
    ]
  end

  before do
    importer.input_upgrade_types = input_upgrade_types
    importer.input_upgrades = input_upgrades
    importer.input_ships = input_ships
    importer.input_actions = input_actions
    importer.input_factions = input_factions
    importer.input_pilots = input_pilots
    importer.input_quick_builds = input_quick_builds
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

  it 'is able to import upgrade types' do
    expect(UpgradeType.count).to be == 2
  end

  it 'is able to import upgrades' do
    expect(Upgrade.count).to be == 2
  end

  it 'is able to import quick builds' do
    expect(QuickBuild.count).to be == 1
  end
end
