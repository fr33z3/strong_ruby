require 'spec_helper'

describe Object do
  let(:some_class) { double(:some_class) }

  describe '#ResolveDependency' do
    it {
      expect(Dependency::Resolver).to receive(:resolve).with(some_class)
      ResolveDependency(some_class)
    }
  end

end