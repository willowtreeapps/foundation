require "set"

class SassVariableExtractor
  # Format: $body-bg: blue !default; // Line comment
  # Match:      1       2            3  4
  REGEX = /\$([^:]+):\s*([^; ]+) !default;\s*(\/\/\s*(.*))?/
  def initialize(filepath)
    @file = File.open(filepath, "r")
    @vars = Set.new
  end

  def extract_sass_variables
    @file.rewind
    @file.lines.each do |line|
      
      if match=REGEX.match(line)
        @vars.add({
          name: match[1],
          value: match[2],
          comment: match[4]
        })
      end
    end
    @vars
  end

  def extract_docs
    @file.rewind
    docs = "\n// #{File.basename(@file.path)}\n"
    started = false
    @file.lines.each do |line|
      if started
        docs += line
        return docs if line.start_with?("// *")
      end
      if line.start_with?("// *") && !started
        started = true
        docs += line
      end
    end
    return docs
  end
end