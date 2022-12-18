require "sketchup.rb"
require "json"
require "fileutils"

SKETCHUP_CONSOLE.show

# Handles opening and saving our tool use history
class FileHandler
  @@file_path = "./Sketchup/NextTool"
  def self.read_json_to_hash(file_name)
    path = @@file_path + "/" + file_name + ".json"
    if File.exists?(path)
      return JSON.parse(raw_data)
    else return Hash.new(false)     end
  end
  def self.save_json(hash, file_name)
    if !File.exists?(@@file_path)
      FileUtils.mkdir_p @@file_path
    end
    File.write(@@file_path + "/" + file_name + ".json", hash.to_json)
  end
end

class MyToolsObserver < Sketchup::ToolsObserver
  @@id = "ToolsObserver"
  @@tools = FileHandler.read_json_to_hash(@@id)
  @@last_tool = ""

  def update_probs(last_tool, tool_name)
    total_entries = @@tools[last_tool]["total_entries"]
    maxVal = 0.0
    mostLikelyTool = ""
    @@tools[last_tool].each do |key, value|
      if key != "total_entries"
        if key == tool_name
          @@tools[last_tool][tool_name] = (value.to_f * total_entries + 1.0) / (total_entries + 1.0)
        else
          @@tools[last_tool][key] = (value.to_f * total_entries) / (total_entries + 1.0)
        end
        if @@tools[last_tool][tool_name] > maxVal
          mostLikelyTool = tool_name
        end
      end
    end
    @@tools[last_tool]["most_likely_tool"] = mostLikelyTool
  end

  def self.set_next_tool()
    if (@@tools[@@last_tool]["most_likely_tool"])
      Sketchup.send_action("select" + @@tools[@@last_tool]["most_likely_tool"] + ":")
    end
  end

  def onActiveToolChanged(tools, tool_name, tool_id)
    if @@last_tool != ""
      if @@tools.key?(@@last_tool)
        if @@tools[@@last_tool].key?(tool_name)
          self.update_probs(@@last_tool, tool_name)
          # @@tools[@@last_tool][tool_name] += 1
          @@tools[@@last_tool]["total_entries"] += 1.0
        else
          @@tools[@@last_tool][tool_name] = 0.0
          self.update_probs(@@last_tool, tool_name)
          @@tools[@@last_tool]["total_entries"] += 1.0
        end
      else
        @@tools[@@last_tool] = Hash.new(false)
        @@tools[@@last_tool][tool_name] = 1.0
        @@tools[@@last_tool]["total_entries"] = 1.0
      end
      @@last_tool = tool_name
    else
      @@last_tool = tool_name
    end
  end

  def self.save_tools()
    FileHandler.save_json(@@tools, @@id)
  end
end

class MyAppObserver < Sketchup::AppObserver
  def onQuit()
    MyToolsObserver.save_tools()
  end
end

plugins_menu = UI.menu("Plugins")
submenu = plugins_menu.add_submenu("Next Tools")
submenu.add_item("Most Likely Next Tool") {
  MyToolsObserver.set_next_tool()
}

# Attach the observer.
Sketchup.add_observer(MyAppObserver.new)
Sketchup.active_model.tools.add_observer(MyToolsObserver.new)
