require 'minitest/autorun'
require 'minitest/pride'
require './lib/vendor'
require './lib/item'
require './lib/market'

class MarketTest < MiniTest::Test

  def test_it_exists
    market = Market.new("South Pearl Street Farmers Market")
    item1 = Item.new({name: "Peach", price: "$0.75"})
    item2 = Item.new({name: "Tomato", price: "$0.50"})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    vendor2 = Vendor.new("Ba-Nom-a-Nom")
    vendor3 = Vendor.new("Palisade Peach Shack")
    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)
    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)
    vendor3.stock(item1, 65)
    vendor3.stock(item3, 10)
    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)
    expected = {
        item1 => {
          quantity: 100,
          vendors: [vendor1, vendor2]
        },
        item2 => {
          quantity: 7,
          vendors: [vendor1]
        },
        item4 => {
          quantity: 50,
          vendors: [vendor2]
        },
        item3=> {
          quantity: 35,
          vendors: [vendor2, vendor3]
        },
      }

    assert_equal expected, market.total_inventory
  end
end