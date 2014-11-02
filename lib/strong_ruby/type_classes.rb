class Or
  def initialize(classes)
    @classes = classes
  end

  def ===(val)
    @classes.map{|c| c === val}.any?
  end

  def self.[](*classes)
    new(classes)
  end
end

class And
  def initialize(classes)
    @classes = classes
  end

  def ===(val)
    @classes.map{|c| c === val}.all?
  end

  def self.[](*classes)
    new(classes)
  end
end

class Pos

  def self.===(val)
    if val.respond_to?(:>=)
      val > 0
    else
      false
    end
  end

end

class Neg
  
  def self.===(val)
    if val.respond_to?(:<)
      val < 0
    else
      false
    end
  end

end