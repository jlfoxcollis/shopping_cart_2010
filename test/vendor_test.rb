require 'minitest/autorun'
require 'minitest/pride'
require './lib/vendor'
require './lib/item'

class VendorTest < MiniTest::Test

  def test_it_exists_and_has_attributes
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_equal "Rocky Mountain Fresh", vendor.name
    assert_equal ({}), vendor.inventory
  end

  def test_stock
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_equal 0, vendor.check_stock(item1)
    vendor.stock(item1, 30)
    assert_equal ({item1 => 30}), vendor.inventory
    assert_equal 30, vendor.check_stock(item1)
    vendor.stock(item1, 25)
    assert_equal 55, vendor.check_stock(item1)
    vendor.stock(item2, 12)
    assert_equal ({item1 => 55, item2 => 12}), vendor.inventory
  end
end
