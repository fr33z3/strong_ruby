require 'spec_helper'

describe StrongType do
  
  class SomeClass
    include StrongType

    Type Fixnum
    def meth1(a); a; end
  end

  class SomeInherited < SomeClass
  end

  class SomeOverrided < SomeClass
    Type String
    def meth1(a); a; end
  end

  describe 'type define behavior' do
    it 'raise exception on method attribute types check fail' do
      expect{ SomeClass.new.meth1('1') }.to raise_error
    end

    it 'passes method on method attributes check success' do
      expect( SomeClass.new.meth1(1) ).to eq 1 
    end
  end

  describe 'type inheritance behavior' do
    it 'raise exception on method attribute types check fail' do
      expect{ SomeInherited.new.meth1('1') }.to raise_error
    end

    it 'passes method on method attributes check success' do
      expect( SomeInherited.new.meth1(1)).to eq 1
    end
  end

  describe 'override behavior' do
    it 'raise exception on method attribute types check fail' do
      expect{ SomeOverrided.new.meth1(1) }.to raise_error
    end

    it 'passes method on method attributes check success' do
      expect( SomeOverrided.new.meth1('1') ).to eq "1"
    end
  end

end