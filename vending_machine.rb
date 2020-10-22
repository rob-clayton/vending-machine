# frozen_string_literal: true

require 'require_all'
require 'pry'

require_all 'controllers'
require_all 'initialisers'
require_all 'lib'
require_all 'models'

# Entry class for the Vending Machine.
class VendingMachine
  attr_reader :balance, :cli, :inventory_controller, :money

  def initialize
    @inventory_controller = InventoryInitialiser.default_load(InventoryController.new)
    @money = Money.new
  end

  def run
    binding.pry
  end
end

    # @balance = 0
  # def insert_coin(coin)
  # end
  #
  # def buy(item_name)
  # end
  #
  # def reload(name, stock)
  # end
# VendingMachine.new.run
