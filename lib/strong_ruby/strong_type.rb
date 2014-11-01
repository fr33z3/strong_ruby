# require 'strong_ruby/strong_type/method_types'

module StrongType
  autoload :MethodTypes, 'strong_ruby/strong_type/method_types'

  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods

    def Type(*attrs)
      __set_unassigned_method_types MethodTypes.new(*attrs)
    end
    
    def method_added(method_name)
      super
      return if __safe_method_definition? || !__unassigned_method_types

      __safe_method_definition! do
        __set_method_types method_name, __unassigned_method_types

        original_method = instance_method(method_name)
        define_method(method_name) do |*attrs, &block|
          self.class.send(:__check_method_types, method_name, *attrs)
          return original_method.bind(self).(*attrs, &block)
        end
      end

      __set_unassigned_method_types(nil)
      method_name
    end

    def inherited(base)
      base.instance_variable_set(:@__method_types, @__method_types.dup)
    end

    private

    def __check_method_types(method_name, attrs)
      types_checker = __method_types_for(method_name)
      types_checker.validate!(attrs)
    end

    def __safe_method_definition!
      @__safe_method_definition = true
      yield
      @__safe_method_definition = false
    end

    def __safe_method_definition?
      @__safe_method_definition || false
    end

    def __set_unassigned_method_types(types)
      @__unassigned_method_types = types
    end

    def __unassigned_method_types
      self.instance_variable_get :@__unassigned_method_types
    end

    def __set_method_types(name, mt)
      @__method_types ||= {}
      @__method_types[name] = mt
    end

    def __method_types
      @__method_types
    end

    def __method_types_for(name)
      @__method_types[name]
    end

  end

end