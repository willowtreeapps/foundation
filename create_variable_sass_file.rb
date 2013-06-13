# Install extract-sass-vars gem
# gem install extract-sass-vars --pre
# Usage: ruby create_variables_files.rb

require "sass"
# require "json"

class Sass::Environment
  attr_accessor :children
  alias old_initialize initialize
  def initialize(parent = nil, options = nil)
    old_initialize(parent,options)
    self.children = []
    if parent
      parent.children << self
    end
  end
end

class VariableExtractor
  def initialize(filename)
    @filename = filename
  end

  def extract
    engine = Sass::Engine.for_file(@filename, {})
    tree = engine.to_tree
    environment = Sass::Environment.new
    visitor = Sass::Tree::Visitors::Perform.new(environment)
    visitor.send(:visit, tree)
    environment.children.each do |child_env|
      vars = child_env.instance_variable_get("@vars")
      return vars
    end
  end
end



variables_dump_file = File.new("_variables_dump.scss", "w")

components = Dir.glob("./scss/foundation/components/**/_*.scss")

file_string = ""

pth = "./scss/foundation/components/_global.scss"
global_vars = VariableExtractor.new(pth).extract
global_vars.each do |setting, value|
  file_string += "$#{setting}: #{value};\n"
end
file_string += "// #{pth}\n"
file_string += "\n"

components.each do |pth|
  puts pth.inspect
  file_string += "// #{pth}\n"
  
  begin
  
  vars = VariableExtractor.new(pth).extract
  vars = vars.reject {|k,v| global_vars.keys.include?(k)}
  vars.each do |setting, value|
    file_string += "$#{setting}: #{value};\n"
  end
  file_string += "\n"
  rescue Exception => e
    puts "ERROR: #{e.inspect}"
  end
end

File.open("_variables_dump.scss", "w") do |f|
  f.puts file_string
end

# Done
puts "Output written to `_variables_dump.scss`"