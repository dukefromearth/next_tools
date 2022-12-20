require "minitest/autorun"
require "../src/next_tools/tool_observer.rb"

class ToolObserverTest < Minitest::Test
  def test_update_probs
    # set up
    tools = {
      "selectTool" => {
        "moveTool" => 1.0,
        "total_entries" => 1.0,
        "most_likely_tool" => "moveTool",
      },
    }
    last_tool = "selectTool"
    tool_name = "moveTool"
    observer = MyToolsObserver.new(tools)

    # call the method
    observer.update_probs(last_tool, tool_name)

    # assert that the probability was updated correctly
    assert_equal 1.0, tools[last_tool][tool_name]
    assert_equal "moveTool", tools[last_tool]["most_likely_tool"]

    # add second tool
    last_tool = "selectTool"
    tool_name = "pushPullTool"
    tools[last_tool][tool_name] = 0.0

    # call the method
    observer.update_probs(last_tool, tool_name)

    # assert that the probability was updated correctly
    assert_equal 0.5, tools[last_tool][tool_name]
    assert_equal "pushPullTool", tools[last_tool]["most_likely_tool"]
  end
end
