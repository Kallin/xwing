# frozen_string_literal: true

require 'test_helper'
require './lib/lib_loader'

class ActionTest < ActiveSupport::TestCase
  test 'loads the expected number of factions' do
    loader = LibLoader.new
    loader.load_factions

    assert_equal(7, Faction.count)
  end

  test 'loads the expected number actions' do
    loader = LibLoader.new
    loader.load_actions

    assert_equal(31, Action.count)
  end

  test 'loads the expected number of ships' do
    loader = LibLoader.new
    # actions and factions are needed for ships
    loader.load_actions
    loader.load_factions

    loader.load_ships

    assert_equal(84, Ship.count)
  end

  test 'loads the expected ships' do
    loader = LibLoader.new
    # actions and factions are needed for ships
    loader.load_actions
    loader.load_factions

    loader.load_ships

    assert_equal(84, Ship.count)
  end
end
