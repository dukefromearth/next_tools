require "fileutils"
require "json"

class FileHandler
  @@file_path = "./Sketchup/NextTool"
  def self.read_json_to_hash(file_name)
    puts @@file_path
    puts file_name
    path = @@file_path + "/" + file_name + ".json"
    if File.exists?(path)
      file = File.read(path)
      puts file
      return JSON.parse(file)
    else return Hash.new(false)     end
  end
  def self.save_json(hash, file_name)
    if !File.exists?(@@file_path)
      FileUtils.mkdir_p @@file_path
    end
    File.write(@@file_path + "/" + file_name + ".json", hash.to_json)
  end
end
