module Findable

  def find_by_name(name)
    self.all.find { |element| element.name == name }
  end

  def find_or_create_by_name(name)
    self.find_by_name(name) == nil ? self.new(name) : self.find_by_name(name)
  end

end
