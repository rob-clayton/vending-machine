# frozen_string_literal: true

require 'spec_helper'

describe Money do
  describe '#calculate_change' do
    context 'validations' do
      it 'returns an empty array when passed no total balance' do
        expect { subject.calculate_change(total_balance: nil, purchase_price: 100) }
          .to raise_error('No total balance given.')
      end

      it 'returns an empty array when passed no purchase price' do
        expect { subject.calculate_change(total_balance: 100, purchase_price: nil) }
          .to raise_error('No purchase price given.')
      end

      it 'returns an empty array when total balance is passed anything but at Integer' do
        error = 'Total balance in wrong format, please provide an Integer'
        expect { subject.calculate_change(total_balance: 15.5, purchase_price: 100) }.to raise_error(error)
        expect { subject.calculate_change(total_balance: '12', purchase_price: 100) }.to raise_error(error)
        expect { subject.calculate_change(total_balance: [1], purchase_price: 100) }.to raise_error(error)
        expect { subject.calculate_change(total_balance: { a: 1 }, purchase_price: 100) }.to raise_error(error)
      end

      it 'returns an empty array when purchase price is passed anything but at Integer' do
        error = 'Purchase price in wrong format, please provide an Integer'
        expect { subject.calculate_change(total_balance: 100, purchase_price: 15.5) }.to raise_error(error)
        expect { subject.calculate_change(total_balance: 100, purchase_price: '12') }.to raise_error(error)
        expect { subject.calculate_change(total_balance: 100, purchase_price: [1]) }.to raise_error(error)
        expect { subject.calculate_change(total_balance: 100, purchase_price: { a: 1 }) }.to raise_error(error)
      end

      it 'returns an empty array when purchase price is more than the total balance' do
        expect { subject.calculate_change(total_balance: 100, purchase_price: 200) }
          .to raise_error('Insufficient funds, please add to your total balance.')
      end
    end
  end
end
