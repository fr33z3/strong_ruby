require 'spec_helper'

describe Dependency::Resolver do
  let(:klass) { Dependency::Resolver }
  let(:binding_class) { Dependency::ResolverBinding }
  let(:resolving_class) { double(:resolving_class) }
  let(:object_constructor) { double(:object_constructor) }
  before(:each) { klass.clear_bindings }

  describe '.bind' do

    it 'makes class binding' do
      klass.bind(resolving_class, object_constructor, true)
      resolve = klass.dependencies[resolving_class]
      expect(resolve).to_not be_nil
      expect(resolve).to be_is_a(binding_class)
    end

    it 'raise error if already has binding for class' do
      expect {
        2.times{ klass.bind(resolving_class, object_constructor, true) }
      }.to raise_error
    end

    it 'creates resolve binding with valid params' do
      expect(binding_class).to receive(:new).with(object_constructor, true)
      klass.bind(resolving_class, object_constructor, true)
    end
  end

  describe '.clear_bindings' do
    it 'clears all bindings' do
      klass.bind(resolving_class, object_constructor, true)
      expect{ klass.clear_bindings }.to change{ klass.dependencies.empty? }.from(false).to(true)
    end
  end

  describe '.resolve' do
    let(:constructed_object) { double(:constructed_object) }
    let(:binding) { double(:resolve_binding) }

    it 'raise error if no depency for requested class' do
      expect{ klass.resolve(resolving_class) }.to raise_error
    end

    it 'returns constrcucted object by dependency' do
      expect(binding_class).to receive(:new).with(object_constructor, true).and_return binding
      expect(binding).to receive(:construct).and_return constructed_object
 
      klass.bind(resolving_class, object_constructor, true)
      expect(klass.resolve(resolving_class)).to eq constructed_object
    end
  end

end