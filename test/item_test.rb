require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest < MiniTest::Test

  def test_it_exists_and_attributes
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})

    assert_equal "Tomato", item2.name
    assert_equal 0.5, item2.price
    assert_instance_of Item, item1
  end
end
