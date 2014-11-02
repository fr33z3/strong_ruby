describe Dependency::ResolverBinding do
  let(:klass) { Dependency::ResolverBinding }
  let(:constructed_object) { double(:constructed_object) }
  let(:object_constructor) { double(:object_constructor) }

  describe '#construct' do
    
    context 'when singleton and object constructed' do
      let(:binding) { klass.new(object_constructor, true) }
      before(:each) do
        binding.instance_variable_set(:@constructed_instance, constructed_object)
      end

      it 'returns already constructed object' do
        expect(binding.construct).to eq constructed_object
      end

      it 'does not call object constructor' do
        expect(object_constructor).to_not receive(:call)
        binding.construct
      end
    end

    context 'when singleton and object not constructed' do
      let(:binding) { klass.new(object_constructor, true) }

      it 'calls object_constructor and return constructed object' do
        expect(object_constructor).to receive(:call).and_return constructed_object
        expect(binding.construct).to eq constructed_object
      end

      it 'caches singleton object' do
        expect(object_constructor).to receive(:call).once.and_return constructed_object
        2.times{ binding.construct }
      end

    end

    context 'when is not singleton' do
      let(:binding) { klass.new(object_constructor, false) }

      it 'calls constructor and return constructed object' do
        expect(object_constructor).to receive(:call).and_return constructed_object
        expect(binding.construct).to eq constructed_object
      end

      it 'does not cache constructed object' do
        expect(object_constructor).to receive(:call).twice.and_return constructed_object
        2.times{ binding.construct }
      end
    end
  end

end