# Install extract-sass-vars gem
# gem install extract-sass-vars --pre
# Usage: ruby create_variables_files.rb

require "json"

variables_dump_file = File.new("_variables_dump.scss", "w")

components = Dir.glob("./scss/foundation/components/**/_*.scss")

file_string = ""

`extract-sass-vars ./scss/foundation/components/_global.scss _global_dump.json`
file_string += "// ./scss/foundation/components/_global.scss\n"
global_json = JSON.parse(File.read("./_global_dump.json"))
global_json.each do |setting, value|
  file_string += "$#{setting}: #{value};\n"
end
file_string += "\n"

components.each do |pth|
  puts pth.inspect
  file_string += "// #{pth}\n"
  filename = File.basename(pth, File.extname(pth))
  cmd = "extract-sass-vars #{pth} #{filename}_dump.json"
  puts cmd
  begin
  `#{cmd}`
  json = JSON.parse(File.read("./#{filename}_dump.json"))
  json = json.reject {|k,v| global_json.keys.include?(k)}
  json.each do |setting, value|
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

# Remove JSON parser files
`rm _*.json`

# Done
puts "Output written to `_variables_dump.scss`"