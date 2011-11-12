module Netzke
  class Base
    def self.add_source_code_tool
      plugin :source_code_tool, :file => caller.first.split(":").first
    end

    def self.add_tutorial_tool(*args)
      plugin :tutorial_tool, *args
    end
  end
end