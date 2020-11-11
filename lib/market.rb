require 'date'

class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
    date
  end

  def date
    Date.today.strftime("%d/%m/%Y")
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def total_inventory
    inventory = Hash.new {|hash, key| hash[key] = {quantity: 0, vendors: []}}
    vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        inventory[item][:quantity] += quantity
        inventory[item][:vendors] << vendor
      end
    end
    inventory
  end

  def vendors_that_sell(item)
    vendors.select do |vendor|
      vendor.inventory.include?(item) && vendor.inventory[item] != 0
    end
  end

  def overstocked_items
    overstock = []
    vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        if vendors_that_sell(item).count > 1 && quantity > 50
          overstock << item
        end
      end
    end
    overstock
  end

  def item_list
    vendors.flat_map do |vendor|
      vendor.inventory.flat_map do |item, quantity|
        item.name
      end
    end
  end

  def sorted_item_list
    item_list.sort.uniq
  end

  def reduce_quantity(item, quantity)
    until quantity == 0 do
      vendors_that_sell(item).map do |vendor|
        balance = vendor.inventory[item] -= quantity
        quantity = 0
        if balance <= 0
          vendor.inventory[item] += balance.abs
          quantity = balance.abs
        end
      end
    end
    quantity
  end

  def sell(item, quantity)
    if total_inventory.include?(item) && quantity <= total_inventory[item][:quantity]
      reduce_quantity(item, quantity)
      true
    else
      false
    end
  end
end
