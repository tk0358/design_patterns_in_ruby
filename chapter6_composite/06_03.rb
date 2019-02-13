# コンポジットの各参加者に親の参照を追加して、ツリーのトップに向かって辿れるように
# コンポーネントクラスに親を扱うコードを入れる

class Task
  attr_accessor :name, :parent

  def initialize(name)
    @name = name
    @parent = nil
  end

  def get_time_required
    0.0
  end
end

class AddDryIngredientsTask < Task

  def initialize
    super('Add dry ingredients')
  end

  def get_time_required
    1.0 # 小麦と砂糖を加えるのに１分
  end
end

class MixTask < Task

  def initialize
    super('Mix that batter up!')
  end

  def get_time_required
    3.0 # 混ぜるのに３分
  end
end

class AddLiquidsTask < Task

  def initialize
    super 'Add Liquids!'
  end

  def get_time_required
    0.5
  end
end

class FillPanTask < Task

  def initialize
    super 'Fill pan!'
  end

  def get_time_required
    2.0
  end
end

class BakeTask < Task

  def initialize
    super 'Bake pan!'
  end

  def get_time_required
    35.0
  end
end

class FrostTask < Task

  def initialize
    super 'Frost pan before package!'
  end

  def get_time_required
    30.0
  end
end

class CompositeTask < Task
  def initialize(name)
    super(name)
    @sub_tasks = []
  end

  def add_sub_task(task)
    @sub_tasks << task
    task.parent = self
  end

  def remove_sub_task(task)
    @sub_tasks.delete(task)
    task.parent = nil
  end

  def get_time_required
    time = 0.0
    @sub_tasks.each {|task| time += task.get_time_required}
    time
  end
end

class MakeBatterTask < CompositeTask
  def initialize
    super('Make batter')
    add_sub_task( AddDryIngredientsTask.new )
    add_sub_task( AddLiquidsTask.new )
    add_sub_task( MixTask.new )
  end
end

class MakeCakeTask < CompositeTask
  def initialize
    super('Make cake')
    add_sub_task( MakeBatterTask.new )
    add_sub_task( FillPanTask.new )
    add_sub_task( BakeTask.new )
    add_sub_task( FrostTask.new )
  end
end

makecake = MakeCakeTask.new
puts makecake.get_time_required

task = MixTask.new
while task
  puts "task: #{task.name}"
  task = task.parent
end