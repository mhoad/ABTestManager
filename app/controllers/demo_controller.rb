class DemoController < ApplicationController
  def dashboard
  end

  def issues
    @issues = CreateDemoData.new.issues
  end

  def single_issue
    @issue = CreateDemoData.new.issues.sample
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
