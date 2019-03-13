require_relative './animal'
require_relative './plant'

class Tree
  def initialize(name)
    @name = name
  end

  def grow
    puts("樹木 #{@name} が高く育っています。")
  end
end

class Tiger
  def initialize(name)
    @name = name
  end

  def eat
    puts("トラ #{@name} は食べたいものを何でも食べます。")
  end

  def speak
    puts("トラ #{@name} はガオーとほえています。")
  end

  def sleep
    puts("トラ #{@name} は眠くなったら眠ります。")
  end
end

class Habitat
  def initialize(number_animals, animal_class,
                 number_plants, plant_class)
    @animal_class = animal_class
    @plant_class = plant_class

    @animals = []
    number_animals.times do |i|
      animal = new_organism(:animal, "動物#{i}")
      @animals << animal
    end

    @plants = []
    number_plants.times do |i|
      plant = new_organism(:plant, "植物#{i}")
      @plants << plant
    end
  end

  def simulate_one_day
    @plants.each {|plant| plant.grow}
    @animals.each {|animal| animal.speak}
    @animals.each {|animal| animal.eat}
    @animals.each {|animal| animal.sleep}
  end

  def new_organism(type, name)
    if type == :animal
      @animal_class.new(name)
    elsif type == :plant
      @plant_class.new(name)
    else
      raise "Unknown organism type: #{type}"
    end
  end
end

jungle = Habitat.new(1, Tiger, 4, Tree)
jungle.simulate_one_day

pond = Habitat.new(2, Duck, 4, WaterLily)
pond.simulate_one_day