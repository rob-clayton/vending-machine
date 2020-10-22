# frozen_string_literal: true

require 'require_all'
require 'pry'

require_all 'controllers'
require_all 'lib'
require_all 'models'

# Entry class for the Vending Machine.
class VendingMachine
  attr_reader :balance, :cli, :inventory, :money

  def initialize
    # @balance = Balance.new
    # @cli = CLI.new
    @inventory = InventoryController.new
    @money = Money.new
  end

  def run
    binding.pry
  end
end

VendingMachine.new.run
