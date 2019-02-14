require 'pathname'

pn = Pathname.new('/mnt/c/Code/ruby/design_patterns_in_ruby/chapter7_iterator')
pn.each_filename{|file| puts("File: #{file}")}
pn.each_entry{|entry| puts("Entry: #{entry}")}
