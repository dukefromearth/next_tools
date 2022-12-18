require "sketchup.rb"
require "extensions.rb"

module NextTool
  PLUGIN_ID = File.basename(__FILE__, ".rb")
  PLUGIN_DIR = File.join(File.dirname(__FILE__), PLUGIN_ID)

  EXTENSION = SketchupExtension.new(
    "Next Tool",
    File.join(PLUGIN_DIR, "main")
  )
  EXTENSION.creator = "Stephen Duke"
  EXTENSION.description =
    "Predict the next most likely tool to be used with a Markov chain."
  EXTENSION.version = "0.0.1"
  EXTENSION.copyright = "#{EXTENSION.creator} 2022"
  Sketchup.register_extension(EXTENSION, true)
end
