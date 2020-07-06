module Affordances
  class Comment
    attr_reader :id, :author, :content
  
    def initialize(**args)
      @id = args[:id]
      @author = args[:author]
      @content = args[:content]
    end

    def likes
      rand(10)
    end
  end
end