module Dependency
  autoload :Resolver, 'strong_ruby/dependency/resolver'
  autoload :ResolverBinding, 'strong_ruby/dependency/resolver_binding'
end

Object.send(:define_method, :ResolveDependency) do |class_name|
  Dependency::Resolver.resolve(class_name)
end