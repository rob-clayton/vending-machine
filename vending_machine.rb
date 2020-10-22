# frozen_string_literal: true

require 'require_all'
require 'pry'

require_all 'controllers'
require_all 'initialisers'
require_all 'lib'
require_all 'models'
require_all 'presenters'

# Entry class for the Vending Machine.
class VendingMachine
  attr_reader :cli, :inventory_controller, :money, :total_balance

  def initialize
    @total_balance = 200
    @inventory_controller = InventoryInitialiser.default_load(InventoryController.new)
    @money = Money.new
  end

  def help
    puts 'The following commands are available:'
    puts 'inventory - prints a table of all items'
    puts 'balance - returns you balance'
    puts "purchase(item_name) - for example purchase('Mars')"
  end

  def inventory
    InventoryTable.new.present(@inventory_controller.inventory)
  end

  def balance
    MoneyPresenter.new.present(total_balance)
  end

  def purchase(item_name)
    item = inventory_controller.find_item(item_name)

    if item.in_stock?
      change = money.calculate_change(total_balance: total_balance, purchase_price: item.price)
      purchase_item(change, item) if change
    else
      "Sorry #{item.name} is out of stock!"
    end
  end

  private

  def purchase_item(change, item)
    puts "Your change is: #{change.map(&:keys).join(', ')}"
    reset_balance
    inventory_controller.minus_one_stock(item.name)
    puts "Here is your #{item.name}!"
  end

  def reset_balance
    @total_balance = 0
  end
end
