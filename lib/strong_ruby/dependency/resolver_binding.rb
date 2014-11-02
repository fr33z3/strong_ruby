module Dependency
  class ResolverBinding
   
    attr_reader :object_constructor

    def initialize(object_constructor, is_singleton)
      @object_constructor = object_constructor
      @is_singleton = is_singleton
    end

    def constructed_instance; @constructed_instance; end
    def constructed_instance?; !@constructed_instance.nil?; end
    def singleton?; @is_singleton; end

    def construct
      if singleton? && constructed_instance?
        return constructed_instance
      end
      obj = object_constructor.call
      @constructed_instance = obj if singleton?
      obj
    end

  end
end