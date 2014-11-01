require 'spec_helper'

describe StrongType::MethodTypes do
  let(:klass) { StrongType::MethodTypes }
  let(:instance) { klass.new(Fixnum, String) }

  describe '#validate!' do
    it 'raises error if types are not ok' do
      expect{ instance.validate!(1,2) }.to raise_error
    end

    it 'does not raise error if types are ok' do
      expect{ instance.validate!(1,'2') }.to_not raise_error
    end

  end

end