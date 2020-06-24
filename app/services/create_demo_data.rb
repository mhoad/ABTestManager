class CreateDemoData
  def issues
    demo_issues = Array.new
    demo_issues.push Affordances::Issue.new(
      title: "Google analytics tracking is not accurate in multiple areas",
      type: "Analytics",
      priority: "Critical",
      status: :in_progress,
      site_area: "Sitewide",
      watchers: 3,
      comments: 9,
      hypotheses: 1
    )
    demo_issues.push Affordances::Issue.new(
      title: "Product pages have multiple UX issues",
      type: "User Experience",
      priority: "Medium",
      site_area: "Product Detail Pages",
      status: :done,
      watchers: 1,
      comments: 3,
      hypotheses: 2
    )
    demo_issues.push Affordances::Issue.new(
      title: "Add to cart button has low contrast",
      type: "User Experience",
      priority: "Low",
      site_area: "Homepage",
      status: :paused,
      watchers: 1,
      comments: 0,
      hypotheses: 4
    )

    demo_issues.push Affordances::Issue.new(
      title: "Icons don't show in internet explorer",
      type: "User Experience",
      priority: "High",
      site_area: "Homepage",
      status: :cancelled,
      watchers: 4,
      comments: 6,
      hypotheses: 1
    )
    demo_issues
  end
end