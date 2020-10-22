require 'pry'

class Money
  COINS = [
    { "£2" => 200 },
    { "£1" => 100 },
    { "50p" => 50 },
    { "20p" => 20 },
    { "10p" => 10 },
    { "5p" => 5 },
    { "2p" => 2 },
    { "1p" => 1 }
  ]

  def calculate_change(total_balance: nil, purchase_price: nil)
    validate_inputs(total_balance, purchase_price)
    recursively_find_change(total_balance - purchase_price)
  end

  def largest_coin(total_balance)
    return nil if total_balance.nil?
    return nil unless total_balance.is_a?(Integer)

    COINS.each_with_object([]) do |coin, matching_coins|
      matching_coins << coin if coin.values.first <= total_balance
    end.sort_by(&:values).last
  end

  private

  def recursively_find_change(remaining_change, change = [])
    return change if remaining_change == 0

    coin = largest_coin(remaining_change)
    recursively_find_change(remaining_change -= coin.values.first, change << coin)
  end

  def validate_inputs(total_balance, purchase_price)
    raise StandardError, NO_TOTAL_BALANCE_ERROR if total_balance.nil?
    raise StandardError, NO_PURCHASE_PRICE_ERROR if purchase_price.nil?
    raise StandardError, TOTAL_BALANCE_NOT_INT_ERROR unless total_balance.is_a?(Integer)
    raise StandardError, PURCHASE_PRICE_NOT_INT_ERROR unless purchase_price.is_a?(Integer)
    raise StandardError, INSUFFICIENT_FUNDS_ERROR if purchase_price > total_balance
  end

  INSUFFICIENT_FUNDS_ERROR = 'Insufficient funds, please add to your total balance.'.freeze
  PURCHASE_PRICE_NOT_INT_ERROR = 'Purchase price in wrong format, please provide an Integer'.freeze
  TOTAL_BALANCE_NOT_INT_ERROR = 'Total balance in wrong format, please provide an Integer'.freeze
  NO_PURCHASE_PRICE_ERROR = 'No purchase price given.'.freeze
  NO_TOTAL_BALANCE_ERROR = 'No total balance given.'.freeze
end
