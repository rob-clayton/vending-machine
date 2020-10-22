# frozen_string_literal: true

# Simple Model for an Item
class Item
  attr_reader :name, :price, :stock

  def initialize(name, price, stock)
    validate_item(name, price, stock)

    @name = name.strip
    @price = price
    @stock = stock
  end

  def in_stock?
    stock.positive?
  end

  private

  def validate_item(name, price, stock)
    raise StandardError, NAME_MUST_BE_STRING unless name.is_a?(String)
    raise StandardError, PRICE_MUST_BE_INT unless price.is_a?(Integer)
    raise StandardError, STOCK_MUST_BE_INT unless stock.is_a?(Integer)
    raise StandardError, NAME_MUST_BE_LETTERS unless %r{^[/_a-zA-Z ]+$} =~ name
    raise StandardError, NAME_MUST_BE_HAVE_ONE_CHAR unless name.strip.length >= 1
  end

  NAME_MUST_BE_HAVE_ONE_CHAR = 'Name must have at least one letter'
  NAME_MUST_BE_LETTERS = 'Name must only contain letters or spaces'
  NAME_MUST_BE_STRING = 'Name must be a String'
  PRICE_MUST_BE_INT = 'Price must be an Integer'
  STOCK_MUST_BE_INT = 'Stock must be an Integer'
end
