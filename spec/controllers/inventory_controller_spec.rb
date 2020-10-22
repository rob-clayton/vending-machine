# frozen_string_literal: true

require 'spec_helper'

describe InventoryController do
  let(:stubbed_item) { Item.new('mars', 100, 10) }

  describe '.new' do
    it 'creates a new inventory' do
      expect(described_class.new.inventory).to eq({})
    end
  end

  describe '#create' do
    before do
      allow(Item).to receive(:new).and_return(stubbed_item)
    end

    it 'creates a new Item' do
      subject.create('mars', 100, 10)

      expect(subject.inventory).to eq({ 'mars' => stubbed_item })
    end

    it 'throws an error if you try to create an item with the same name' do
      expect do
        subject.create('mars', 100, 10)
        subject.create('mars', 200, 8)
      end
        .to raise_error('An item with that name already exists')
    end
  end

  describe '#find_item' do
    before do
      allow(Item).to receive(:new).and_return(stubbed_item)
      subject.create('mars', 100, 10)
    end

    it 'finds an Item in the inventory' do
      expect(subject.find_item('mars')).to eq(stubbed_item)
    end

    it 'returns null if the item cannon be found' do
      expect(subject.find_item('not there')).to eq(nil)
    end
  end

  describe 'update' do
    before do
      subject.create('mars', 100, 10)
    end
    describe '#update' do
      it 'updates an Item in the inventory' do
        subject.update('mars', 120, 20)
        expect(subject.inventory['mars'].price).to eq(120)
        expect(subject.inventory['mars'].stock).to eq(20)
      end

      it 'throws an error if the price is anything but a positive number' do
        error = 'Cannot have a price below 0'
        expect { subject.update('mars', -2, 10) }.to raise_error(error)
        expect { subject.update('mars', nil, 10) }.to raise_error(error)
        expect { subject.update('mars', [], 10) }.to raise_error(error)
        expect { subject.update('mars', '2', 10) }.to raise_error(error)
        expect { subject.update('mars', {}, 10) }.to raise_error(error)
      end

      it 'throws an error if the stock is anything but a positive number' do
        error = 'Cannot have stock below 0'
        expect { subject.update('mars', 120, -2) }.to raise_error(error)
        expect { subject.update('mars', 120, nil) }.to raise_error(error)
        expect { subject.update('mars', 120, []) }.to raise_error(error)
        expect { subject.update('mars', 120, '2') }.to raise_error(error)
        expect { subject.update('mars', 120, {}) }.to raise_error(error)
      end
    end

    describe '#update_stock' do
      it 'updates an Item in the inventory' do
        subject.update_stock('mars', 30)

        expect(subject.inventory['mars'].stock).to eq(30)
      end
    end

    describe '#minus_one_stock' do
      it 'updates an Item in the inventory' do
        subject.minus_one_stock('mars')

        expect(subject.inventory['mars'].stock).to eq(9)
      end

      it 'throws an error if the stock is at 0' do
        subject.create('twix', 100, 0)
        error = 'Cannot have stock below 0'
        expect { subject.minus_one_stock('twix') }.to raise_error(error)
      end
    end
  end

  describe '#delete' do
    it 'deletes an item from the inventory' do
      subject.create('mars', 100, 10)
      subject.delete('mars')
      expect(subject.inventory).to eq({})
    end
  end
end
