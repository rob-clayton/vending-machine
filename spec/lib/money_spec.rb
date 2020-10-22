# frozen_string_literal: true

require 'spec_helper'

describe Money do

  before do
    stub_const("Money::COINS", [
      { "£2" => 200 },
      { "£1" => 100 },
      { "50p" => 50 },
      { "20p" => 20 },
      { "10p" => 10 },
      { "5p" => 5 },
      { "2p" => 2 },
      { "1p" => 1 }
    ])
  end

  describe '#calculate_change' do
    context 'validations' do
      it 'raises an error when passed no total balance' do
        expect { subject.calculate_change(total_balance: nil, purchase_price: 100) }
          .to raise_error('No total balance given.')
      end

      it 'raises an error when passed no purchase price' do
        expect { subject.calculate_change(total_balance: 100, purchase_price: nil) }
          .to raise_error('No purchase price given.')
      end

      it 'raises an error when total balance is passed anything but at Integer' do
        error = 'Total balance in wrong format, please provide an Integer'
        expect { subject.calculate_change(total_balance: 15.5, purchase_price: 100) }.to raise_error(error)
        expect { subject.calculate_change(total_balance: '12', purchase_price: 100) }.to raise_error(error)
        expect { subject.calculate_change(total_balance: [1], purchase_price: 100) }.to raise_error(error)
        expect { subject.calculate_change(total_balance: { a: 1 }, purchase_price: 100) }.to raise_error(error)
      end

      it 'raises an error when purchase price is passed anything but at Integer' do
        error = 'Purchase price in wrong format, please provide an Integer'
        expect { subject.calculate_change(total_balance: 100, purchase_price: 15.5) }.to raise_error(error)
        expect { subject.calculate_change(total_balance: 100, purchase_price: '12') }.to raise_error(error)
        expect { subject.calculate_change(total_balance: 100, purchase_price: [1]) }.to raise_error(error)
        expect { subject.calculate_change(total_balance: 100, purchase_price: { a: 1 }) }.to raise_error(error)
      end

      it 'raises an error when purchase price is more than the total balance' do
        expect { subject.calculate_change(total_balance: 100, purchase_price: 200) }
          .to raise_error('Insufficient funds, please add to your total balance.')
      end
    end

    context '#recursively_find_change' do
      it 'returns change using the highest coin possible' do
        expect(subject.calculate_change(total_balance: 200, purchase_price: 0)).to eq([{"£2"=>200}])
        expect(subject.calculate_change(total_balance: 100, purchase_price: 0)).to eq([{"£1"=>100}])
        expect(subject.calculate_change(total_balance: 50, purchase_price: 0)).to eq([{"50p"=>50}])
        expect(subject.calculate_change(total_balance: 20, purchase_price: 0)).to eq([{"20p"=>20}])
        expect(subject.calculate_change(total_balance: 10, purchase_price: 0)).to eq([{"10p"=>10}])
        expect(subject.calculate_change(total_balance: 5, purchase_price: 0)).to eq([{"5p"=>5}])
        expect(subject.calculate_change(total_balance: 2, purchase_price: 0)).to eq([{"2p"=>2}])
        expect(subject.calculate_change(total_balance: 1, purchase_price: 0)).to eq([{"1p"=>1}])
      end

      it 'combines coins to give to most efficient amount of coins' do
        expect(subject.calculate_change(total_balance: 388, purchase_price: 0)).to eq([{"£2"=>200}, {"£1"=>100}, {"50p"=>50}, {"20p"=>20}, {"10p"=>10}, {"5p"=>5}, {"2p"=>2}, {"1p"=>1}])
        expect(subject.calculate_change(total_balance: 400, purchase_price: 0)).to eq([{"£2"=>200}, {"£2"=>200}])
        expect(subject.calculate_change(total_balance: 51, purchase_price: 0)).to eq([{"50p"=>50}, {"1p"=>1}])
        expect(subject.calculate_change(total_balance: 3, purchase_price: 0)).to eq([{"2p"=>2}, {"1p"=>1}])
        expect(subject.calculate_change(total_balance: 45, purchase_price: 0)).to eq([{"20p"=>20}, {"20p"=>20}, {"5p"=>5}])
      end
    end

    context '#largest_coin' do
      it 'returns nil when passed no total balance or 0' do
        expect(subject.largest_coin(0)).to eq(nil)
        expect(subject.largest_coin(nil)).to eq(nil)
      end

      it 'returns the largest coin possible' do
        expect(subject.largest_coin(300)).to eq({"£2"=>200})
        expect(subject.largest_coin(201)).to eq({"£2"=>200})
        expect(subject.largest_coin(200)).to eq({"£2"=>200})
        expect(subject.largest_coin(199)).to eq({"£1"=>100})
        expect(subject.largest_coin(101)).to eq({"£1"=>100})
        expect(subject.largest_coin(100)).to eq({"£1"=>100})
        expect(subject.largest_coin(99)).to eq({"50p"=>50})
        expect(subject.largest_coin(51)).to eq({"50p"=>50})
        expect(subject.largest_coin(50)).to eq({"50p"=>50})
        expect(subject.largest_coin(49)).to eq({"20p"=>20})
        expect(subject.largest_coin(21)).to eq({"20p"=>20})
        expect(subject.largest_coin(20)).to eq({"20p"=>20})
        expect(subject.largest_coin(19)).to eq({"10p"=>10})
        expect(subject.largest_coin(11)).to eq({"10p"=>10})
        expect(subject.largest_coin(10)).to eq({"10p"=>10})
        expect(subject.largest_coin(9)).to eq({"5p"=>5})
        expect(subject.largest_coin(6)).to eq({"5p"=>5})
        expect(subject.largest_coin(5)).to eq({"5p"=>5})
        expect(subject.largest_coin(4)).to eq({"2p"=>2})
        expect(subject.largest_coin(2)).to eq({"2p"=>2})
        expect(subject.largest_coin(1)).to eq({"1p"=>1})
      end

      it 'returns nil when passed anything but at Integer' do
        error = 'Purchase price in wrong format, please provide an Integer'
        expect(subject.largest_coin(15.5)).to eq(nil)
        expect(subject.largest_coin('12')).to eq(nil)
        expect(subject.largest_coin([1])).to eq(nil)
        expect(subject.largest_coin({ a: 1 })).to eq(nil)
        expect(subject.largest_coin({})).to eq(nil)
        expect(subject.largest_coin([])).to eq(nil)
      end
    end
  end
end
