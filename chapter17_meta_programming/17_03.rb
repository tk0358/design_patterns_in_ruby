require_relative './composite_base'

class Tiger < CompositeBase
  member_of(:population)
  member_of(:classification)

  # 省略...
end

class Tree < CompositeBase
  member_of(:population)
  member_of(:classification)

  # 省略...
end

class Jungle < CompositeBase
  composite_of(:population)

  # 省略...
end

class Species < CompositeBase
  composite_of(:classification)

  # 省略...
end

# トラの一種が、あるジャングルに生息している
tony_tiger = Tiger.new('tony')
se_jungle = Jungle.new('southeastern jungle')
se_jungle.add_sub_population(tony_tiger)

p tony_tiger.parent_population
p tony_tiger.parent_population.name

# トラの一種は、P.tigris種である
species = Species.new('P.tigris')
species.add_sub_classification(tony_tiger)

p tony_tiger.parent_classification #=> 'P.tigris'を返す
p tony_tiger.parent_classification.name

