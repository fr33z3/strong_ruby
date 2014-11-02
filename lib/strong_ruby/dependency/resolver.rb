module Dependency
  class Resolver
    @@dependencies = {}
    def self.dependencies; @@dependencies; end

    def self.bind(class_name, object_constructor, is_singleton)
      if dependencies[class_name]
        raise StandardError.new("Already has binding of class `#{class_name}`")
      end
      dependencies[class_name] = ResolverBinding.new(object_constructor, is_singleton)
    end

    def self.resolve(class_name)
      unless dependencies[class_name]
        raise StandardError.new("Can't find bind for class name `#{class_name}`")
      end
      dependencies[class_name].construct
    end

    def self.clear_bindings
      @@dependencies = {}
    end
  end
end