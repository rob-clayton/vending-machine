# frozen_string_literal: true

require 'terminal-table'

# Uses the terminal-table gem to format and print a table to STDOUT
class InventoryTable
  TITLE = 'Vending Machine'
  NAME = 'Name'
  PRICE = 'Price'
  STOCK = 'Stock'

  def present(inventory)
    return unless inventory.is_a?(Hash)
    return if inventory.empty?

    puts_table(inventory.values.map do |item|
      [
        item.name,
        item.price,
        item.stock
      ]
    end)
  end

  private

  def puts_table(rows)
    puts Terminal::Table.new(
      title: TITLE,
      headings: [NAME, PRICE, STOCK],
      rows: rows
    )
  end
end
