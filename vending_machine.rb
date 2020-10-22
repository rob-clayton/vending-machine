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
  attr_reader :balance, :cli, :inventory_controller, :money

  def initialize
    @inventory_controller = InventoryInitialiser.default_load(InventoryController.new)
    @money = Money.new
  end

  def inventory
    InventoryTable.new.present(@inventory_controller.inventory)
  end
end
