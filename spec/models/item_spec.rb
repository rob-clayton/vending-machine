# frozen_string_literal: true

require 'spec_helper'

describe Item do
  describe '.new' do
    it 'creates a new Item' do
      item = described_class.new('mars', 120, 8)
      expect(item.name).to eq('mars')
      expect(item.price).to eq(120)
      expect(item.stock).to eq(8)
    end

    it 'throws an error unless name of at least one letters and white space' do
      error = 'Name must only contain letters or spaces'
      expect { described_class.new('mars1', 120, 8) }.to raise_error(error)
      expect { described_class.new('1', 120, 8) }.to raise_error(error)
      expect { described_class.new('', 120, 8) }.to raise_error(error)
      expect { described_class.new('m@rs!', 120, 8) }.to raise_error(error)
      expect { described_class.new('m@rs', 120, 8) }.to raise_error(error)
    end

    it 'strips trailing and leading white space from name' do
      expect(described_class.new('mars ', 120, 8).name).to eq('mars')
      expect(described_class.new('     mars ', 120, 8).name).to eq('mars')
      expect(described_class.new('     m  ars ', 120, 8).name).to eq('m  ars')
    end

    it 'throws an error unless name has at least one letter' do
      error = 'Name must have at least one letter'
      expect { described_class.new(' ', 120, 8) }.to raise_error(error)
      expect { described_class.new('   ', 120, 8) }.to raise_error(error)
    end

    it 'throws an error unless name is a String' do
      error = 'Name must be a String'
      expect { described_class.new(12, 120, 8) }.to raise_error(error)
      expect { described_class.new(12.3, 120, 8) }.to raise_error(error)
      expect { described_class.new([], 120, 8) }.to raise_error(error)
      expect { described_class.new({}, 120, 8) }.to raise_error(error)
      expect { described_class.new(nil, 120, 8) }.to raise_error(error)
    end

    it 'throws an error unless price is an Integer' do
      error = 'Price must be an Integer'
      expect { described_class.new('mars', '12', 8) }.to raise_error(error)
      expect { described_class.new('mars', 12.3, 8) }.to raise_error(error)
      expect { described_class.new('mars', [], 8) }.to raise_error(error)
      expect { described_class.new('mars', {}, 8) }.to raise_error(error)
      expect { described_class.new('mars', nil, 8) }.to raise_error(error)
    end

    it 'throws an error unless stock is an Integer' do
      error = 'Stock must be an Integer'
      expect { described_class.new('mars', 120, '12') }.to raise_error(error)
      expect { described_class.new('mars', 120, 12.3) }.to raise_error(error)
      expect { described_class.new('mars', 120, []) }.to raise_error(error)
      expect { described_class.new('mars', 120, {}) }.to raise_error(error)
      expect { described_class.new('mars', 120, nil) }.to raise_error(error)
    end
  end
end
