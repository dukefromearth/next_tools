require "next_tools/tool_observer"
require "next_tools/app_observer"
require "next_tools/file_handler"

module NextTool
  SKETCHUP_CONSOLE.show
  file_name = "NextTool"
  # Add items to menu
  plugins_menu = UI.menu("Plugins")
  submenu = plugins_menu.add_submenu("Next Tools")
  submenu.add_item("Most Likely Next Tool") {
    MyToolsObserver.set_next_tool()
  }
  submenu.add_item("Clear Tool History") {
    MyToolsObserver.clear_tools()
  }

  previous_tools = FileHandler.read_json_to_hash(file_name)
  tools_observer = MyToolsObserver.new(previous_tools)
  app_observer = MyAppObserver.new(tools_observer, file_name)

  # Attach the observers
  Sketchup.add_observer(app_observer)
  Sketchup.active_model.tools.add_observer(tools_observer)
end
