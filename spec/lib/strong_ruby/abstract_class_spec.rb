require 'spec_helper'

describe AbstractClass do
  
  class AbstractStub
    include AbstractClass

    abstract_method :do_something
  end

  class ProperlyImplemented < AbstractStub
    def do_something
    end
  end

  class UnproperlyImplemented < AbstractStub
  end

  it { expect{AbstractStub.new}.to raise_error }
  it { expect{ProperlyImplemented.new.do_something}.to_not raise_error }
  it { expect{UnproperlyImplemented.new.do_something}.to raise_error("You have to implement method do_something in UnproperlyImplemented class")}

end