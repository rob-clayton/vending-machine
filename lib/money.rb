class Money
  def calculate_change(total_balance: nil, purchase_price: nil)
    validate_inputs(total_balance, purchase_price)
  end

  private

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
