class Vendor
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def stock(item, quantity)
    inventory[item] += quantity
  end

  def check_stock(item)
    if inventory.include?(item)
      inventory[item]
    else
      0
    end
  end
end
