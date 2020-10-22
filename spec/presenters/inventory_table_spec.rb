# frozen_string_literal: true

require 'spec_helper'

describe InventoryTable do
  describe '#present' do
    it 'does not print anything to STDOUT when passed an empty Hash' do
      expect { subject.present({}) }.to_not output.to_stdout
    end

    it 'does not print anything to STDOUT when passed anything not Hash' do
      expect { subject.present([]) }.to_not output.to_stdout
      expect { subject.present('String') }.to_not output.to_stdout
      expect { subject.present(123) }.to_not output.to_stdout
      expect { subject.present(12.34) }.to_not output.to_stdout
      expect { subject.present(:symbol) }.to_not output.to_stdout
      expect { subject.present(nil) }.to_not output.to_stdout
    end
  end
end
