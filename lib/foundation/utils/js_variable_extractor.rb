class JsVariableExtractor
  # Format: "version" : "4.2.2"
  #  Match:              4
  REGEX = /('|")?version('|")?\s*\:\s*('|")(.+)('|")/

  def initialize(filepath)
    raise "MissingJsFile" unless File.exists?(filepath)
    @filepath = filepath
  end

  def set_version!(version)
    content = File.read(@filepath)
    if match=REGEX.match(content)
      # Don't rewrite file if version unchanged
      return if match[4] == version
      content.gsub!(REGEX, "version: '#{version}'")
      File.open(@filepath, "w") do |f|
        f.puts content
      end
    end
  end
end