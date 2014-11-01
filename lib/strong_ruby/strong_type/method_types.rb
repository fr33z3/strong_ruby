module StrongType
  class MethodTypes
    attr_reader :types
    
    def initialize(*attrs)
      @types = attrs
    end

    def validate!(*attrs)
      type_check = types.each_with_index.map do |type, i|
        type === attrs[i]
      end.all?
      unless type_check
        raise StandardError.new("types are incorrect")
      end
    end

  end
end