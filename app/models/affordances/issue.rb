module Affordances
  class Issue
    attr_reader :title, :priority, :status, :site_area, :watchers, :comments, :hypotheses
  
    def initialize(**args)
      @title = args[:title]
      @priority = args[:priority]
      @status = args[:status]
      @site_area = args[:site_area]
      @watchers = args[:watchers]
      @comments = args[:comments]
      @hypotheses = args[:hypotheses]
    end
  end
end
