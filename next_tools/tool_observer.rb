require "next_tools/file_handler"

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
