require "next_tools/file_handler"

# Saves the gathered data to a json file on quit
class MyAppObserver < Sketchup::AppObserver
  def initialize(observer, file_name)
    @tools_observer = observer
    @file_name = file_name
  end

  def onQuit()
    puts @file_name
    FileHandler.save_json(@tools_observer.get_tools, @file_name)
  end
end
