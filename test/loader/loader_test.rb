require "test_helper"
require './lib/lib_loader.rb'

class ActionTest < ActiveSupport::TestCase

  test "loads the expected factions" do
    loader = LibLoader.new
    loader.load_factions

    assert_equal(7, Faction.count)
  end

  test "loads the expected actions" do
    loader = LibLoader.new
    loader.load_actions

    assert_equal(31, Action.count)
  end

end