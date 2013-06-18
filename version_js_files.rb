#!/usr/bin/env ruby
require "./lib/foundation/version"
require "./lib/foundation/utils/js_variable_extractor"

major_num = Foundation::VERSION.split(".").first
branch = `git branch`.lines.select {|l| l.start_with?("*")}.first.chop.split("* ").last
tags = `git tag`.split("\n").map(&:chomp).select {|t| t.start_with?("v#{major_num}")}

if tags.include?("v#{Foundation::VERSION}")
  raise "Please update Foundation::VERSION"
end

# If no major tags available, then update everything
if tags.select {|t| t.start_with?("v#{major_num}")}.empty?
  puts "This is the first major release, please update everything"
end

# Look for commit ID of the most recent tag
puts "Released version: #{tags.max}"
puts "Current version: v#{Foundation::VERSION}"

tag = "v4.2.2"
# tag = tags.max
files = `git diff --name-only #{tag} HEAD`.split("\n").map(&:chomp)


# JS files that changed
js_files = files.select {|pth| pth.start_with?("js/") && File.extname(pth) === ".js"}
sass_files = files.select {|pth| pth.start_with?("scss/") && File.extname(pth) === ".scss"}

# Increment JS File Versions
js_files.each do |pth|
  extractor = JsVariableExtractor.new(pth)
  extractor.set_version!(Foundation::VERSION)
end

# Increment Sass File Versions
# sass_files.each do |pth|

# end