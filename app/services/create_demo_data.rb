class CreateDemoData
  def issues
    demo_issues = Array.new
    demo_issues.push Affordances::Issue.new(
      id: 1,
      title: "Google analytics tracking is not accurate in multiple areas",
      type: "Analytics",
      priority: "Critical",
      status: :in_progress,
      site_area: "Sitewide"
    )
    demo_issues.push Affordances::Issue.new(
      id: 2,
      title: "Product pages have multiple UX issues",
      type: "User Experience",
      priority: "Medium",
      site_area: "Product Detail Pages",
      status: :done
    )
    demo_issues.push Affordances::Issue.new(
      id: 3,
      title: "Add to cart button has low contrast",
      type: "User Experience",
      priority: "Low",
      site_area: "Homepage",
      status: :paused
    )

    demo_issues.push Affordances::Issue.new(
      id: 4,
      title: "Icons don't show in internet explorer",
      type: "User Experience",
      priority: "High",
      site_area: "Homepage",
      status: :cancelled
    )
    demo_issues
  end

  def users
    
  end

  def issue_comments
    demo_comments = Array.new

    demo_comments.push Affordances::Comment.new(id: 1, author: "Some Rando", content: "Nice idea!")

    return demo_comments
  end
end