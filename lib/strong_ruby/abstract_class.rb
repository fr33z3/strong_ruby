module AbstractClass
  def self.included(base)
    base.instance_variable_set(:@_abstract_class, true)
    base.instance_variable_set(:@_abstract_methods, [])
    base.send :extend, ClassMethods
    base.send :include, InstanceMethods
    base.send :include, StrongType
  end

  module InstanceMethods
    def initialize(*attrs)
      if self.class.is_abstract_class?
        raise StandardError.new("You can't get instance of abstract class")
      end
    end
  end

  module ClassMethods
    def abstract_method name
      @_abstract_methods << name
      define_method name do |*args|
        raise NotImplementedError.new("You have to implement method #{name} in #{self.class} class")
      end
    end

    def abstract_methods
      @_abstract_methods
    end

    def is_abstract_class?
      @_abstract_class == true
    end
  end

end