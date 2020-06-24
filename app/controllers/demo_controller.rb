class DemoController < ApplicationController
  def dashboard
  end

  def issues
    @issues = CreateDemoData.new.issues
  end

  def hypotheses
  end

  def tests
  end

  def learnings
  end

  def tools
  end

  def team
  end
end
