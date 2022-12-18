require "next_tools/tool_observer"

# Saves the gathered data to a json file on quit
class MyAppObserver < Sketchup::AppObserver
  def onQuit()
    MyToolsObserver.save_tools()
  end
end
