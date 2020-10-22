# frozen_string_literal: true

require_relative '../models/item'

# This is the entry to the Inventory, designed as an easier way to manage Items.
class InventoryController
  attr_reader :inventory

  def initialize
    @inventory = {}
  end

  def create(name, price, stock)
    raise StandardError, 'An item with that name already exists' if find_item(name)

    inventory[name] = Item.new(name, price, stock)
  end

  def find_item(name)
    inventory[name]
  end

  def minus_one_stock(name)
    item = find_item(name)
    raise StandardError, 'Cannot have stock below 0' if item.stock <= 0

    update(name, item.price, item.stock - 1)
  end

  def update_stock(name, updated_stock)
    update(name, find_item(name).price, updated_stock)
  end

  def update(name, price, stock)
    raise StandardError, 'Cannot have stock below 0' unless stock.is_a?(Integer) && stock.positive?
    raise StandardError, 'Cannot have a price below 0' unless price.is_a?(Integer) && price.positive?

    inventory[name] = Item.new(name, price, stock)
  end

  def delete(name)
    inventory.delete(name)
  end
end
