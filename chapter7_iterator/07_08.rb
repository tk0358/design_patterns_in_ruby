#ObjectSpace.each_object{|object| puts("Object: #{object}")}
ObjectSpace.each_object(Numeric) {|n| puts("The number is #{n}")}

def subclass_of(superclass)
  subclasses = []
  ObjectSpace.each_object(Class) do |k|
    next if !k.ancestors.include?(superclass) || superclass == k ||
            k.to_s.include?('::') || subclasses.include?(k.to_s)
    subclasses << k.to_s
  end
  subclasses
end

p subclass_of(Object)
