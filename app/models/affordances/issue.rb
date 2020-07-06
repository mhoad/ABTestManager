module Affordances
  class Issue
    attr_reader :id, :title, :priority, :status, :site_area, :watchers, :comments, :hypotheses
  
    def initialize(**args)
      @id = args[:id]
      @title = args[:title]
      @priority = args[:priority]
      @status = args[:status]
      @site_area = args[:site_area]
    end

    def get_comments
      CreateDemoData.new.issue_comments
    end

    def comments
      rand(10)
    end

    def watchers
      rand(1..4)
    end

    def hypotheses
      rand(3)
    end

    def created_at
      updated_at - rand(15552000)
    end

    def updated_at
      Time.now - rand(15552000)
    end
  end
end
