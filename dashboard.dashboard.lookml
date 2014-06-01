- dashboard: stats
  title: "Stats"
  layout: tile
  tile_size: 100

  elements:

  - name: headlines
    title: Smashes
    type: single_value
    base_view: headlines
    measures: [headlines.count]
    height: 2

  - name: source_headlines
    title: Source Headlines
    type: single_value
    base_view: source_headlines
    measures: [source_headlines.count]
    height: 2

  - name: votes_by_retention
    title: Votes by Sign in Count
    type: looker_area
    base_view: headlines
    dimensions: [users.sign_in_count]
    measures: [headlines.total_vote_count]
    filters:
      users.sign_in_count: not NULL
    sorts: [users.sign_in_count]
    interpolation: monotone
    hide_points: true

  - name: karma_by_retention
    title: Total Karma by Sign in Count
    type: looker_area
    base_view: users
    dimensions: [users.sign_in_count]
    measures: [users.total_karma]
    sorts: [users.sign_in_count]
    interpolation: monotone
    hide_points: true
    colors: crimson

  - name: avg_karma_by_retention
    title: Average Karma by Sign in Count
    type: looker_column
    base_view: users
    dimensions: [users.sign_in_count_tier]
    measures: [users.average_karma]
    sorts: [users.sign_in_count_tier]
    interpolation: monotone
    hide_points: true
    colors: green


  - name: sources
    title: Source Headline Sources
    type: looker_pie
    base_view: source_headlines
    dimensions: [source_headlines.source_id]
    measures: [source_headlines.count]
