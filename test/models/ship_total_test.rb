require "test_helper"

class ShipTotalTest < ActiveSupport::TestCase

  test "ship counts can be tallied" do
    (user = User.new(email: 'test@tester.com', password: 'password')).save!
    (ship_a= Ship.new).save!
    (ship_b = Ship.new).save!
    (collection = Collection.new(user: user)).save!
    collection.add_ship(ship_a)
    collection.add_ship(ship_a)
    collection.add_ship(ship_b)

    assert_equal(3, user.collection.total_ship_count, "our collection should have 3 ships")
  end

end
