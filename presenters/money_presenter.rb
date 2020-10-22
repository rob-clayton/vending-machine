# frozen_string_literal: true

# holds the logic for formatting and presenting a balance
class MoneyPresenter
  def present(balance)
    "Balance: #{format_money(balance)}"
  end

  private

  def format_money(balance)
    "£#{format('%.2f', (balance.to_f / 100))}"
  end
end
