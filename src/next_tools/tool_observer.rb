require "next_tools/file_handler"

class MyToolsObserver < Sketchup::ToolsObserver
  @@id = "ToolsObserver"
  @@tools = FileHandler.read_json_to_hash(@@id)
  @@last_tool = ""
  @@errors = []

  def update_probs(last_tool, tool_name)
    total_entries = @@tools[last_tool]["total_entries"]
    max_probability = 0.0
    probability = 0.0
    most_likely_tool = ""
    @@tools[last_tool].each do |key, value|
      if key != "total_entries" && key != "most_likely_tool"
        if key == tool_name
          probability = (value.to_f * total_entries + 1.0) / (total_entries + 1.0)
          @@tools[last_tool][tool_name] = probability
        else
          probability = (value.to_f * total_entries) / (total_entries + 1.0)
          @@tools[last_tool][key] = probability
        end
        if probability >= max_probability
          most_likely_tool = key
          max_probability = probability
        end
      end
    end
    @@tools[last_tool]["most_likely_tool"] = most_likely_tool
  end

  def self.set_next_tool()
    begin
      tool = @@tools[@@last_tool]["most_likely_tool"]
    rescue => exception
      @@errors.push(exeception)
    else
      Sketchup.send_action("select" + tool + ":")
    end
  end

  def self.clear_tools()
    @@tools = Hash.new(false)
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
