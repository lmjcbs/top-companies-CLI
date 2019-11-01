module Concerns

  module Findable

    def find_by_name(name)
      self.all.find { |element| element.name == name }
    end

    def find_or_create_by_name(name)
      self.find_by_name(name) == nil ? self.create(name) : self.find_by_name(name)
    end

  end

  module Utilities

    def all
      @@all
    end

    def save
      @@all << self
    end

    def create(name)
      new_instance = self.new(name)
      new_instance.save
      new_instance
    end
    
  end

end