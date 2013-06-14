#!/usr/bin/env ruby
# USAGE ./create_variable_sass_file.rb
require "./lib/foundation/utils/sass_variable_extractor"

output_file = File.new("./scss/foundation/_variables.scss", "w")
sass_files = Dir.glob("./scss/foundation/components/**/_*.scss")
sass_files.each do |pth|
  # puts "Processing: #{pth}"
  sve = SassVariableExtractor.new(pth)
  output_file.puts sve.extract_docs
  sve.extract_sass_variables.each do |v|
    line  = "// $#{v[:name]}: #{v[:value]};"
    line += " // #{v[:comment]}" if v[:comment]
    output_file.puts line
  end
end
output_file.close

puts "Output written to: #{output_file.path}"