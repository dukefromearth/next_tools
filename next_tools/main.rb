require "next_tools/tool_observer.rb"

module NextTool
  SKETCHUP_CONSOLE.show

  # Add items to menu
  plugins_menu = UI.menu("Plugins")
  submenu = plugins_menu.add_submenu("Next Tools")
  submenu.add_item("Most Likely Next Tool") {
    MyToolsObserver.set_next_tool()
  }

  # Saves the gathered data to a json file on quit
  class MyAppObserver < Sketchup::AppObserver
    def onQuit()
      MyToolsObserver.save_tools()
    end
  end

  # Attach the observers
  Sketchup.add_observer(MyAppObserver.new)
  Sketchup.active_model.tools.add_observer(MyToolsObserver.new)
end
