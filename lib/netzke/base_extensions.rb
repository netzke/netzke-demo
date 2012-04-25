module Netzke
  class Base
    def self.add_source_code_tool
      caller_file = caller.first.split(":").first
      plugin :source_code_tool do |c|
        c.file = caller_file
      end
    end

    def self.add_tutorial_tool(*args)
      plugin :tutorial_tool do |c|
        c.merge! args.first
      end
    end
  end
end
