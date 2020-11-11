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
    list = []
    vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        list << item.name
      end
    end
    list
  end

  def sorted_item_list
    item_list.sort.uniq
  end

  def sell(item, quantity)
    if total_inventory.include?(item) && quantity <= total_inventory[item][:quantity]
      total = quantity
      until total == 0 do
        vendors_that_sell(item).map do |vendor|
          balance = vendor.inventory[item] -= total
          total = 0
          if balance <= 0
            vendor.inventory[item] += balance.abs
            total = balance.abs
          end
        end
      end
      true
    else
      false
    end
  end
end
