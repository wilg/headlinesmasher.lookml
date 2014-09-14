- dashboard: stats
  title: "Headline Smasher Overview"
  layout: tile
  tile_size: 100

  filters:

    - name: time
      title: "Date Range"
      type: date_filter
      default_value: Last 3 months

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
    
  - name: tweeted
    title: Tweeted
    type: single_value
    base_view: votes
    measures: [headlines.count]
    filters:
      headlines.bot_tweeted: 'Yes'
    sorts: [headlines.count desc]
    limit: 500
    show_null_labels: false
    height: 2

  - name: untweeted
    title: Untweeted
    type: single_value
    base_view: votes
    measures: [headlines.count]
    filters:
      headlines.bot_tweeted: 'No'
      users.id: '1'
      votes.value: '>0'
    sorts: [headlines.count desc]
    show_null_labels: false
    height: 2

  - name: usage
    title: Daily Smashes 
    type: looker_area
    base_view: headlines
    dimensions: [headlines.created_date]
    measures: [headlines.count,]
    sorts: [headlines.count desc]
    hide_points: true
    stacking: ''
    x_axis_scale: auto
    interpolation: linear
    listen:
      time: headlines.created_date
    width: 12
    
  - name: usage_week
    title: Weekly Smashes 
    type: looker_area
    base_view: headlines
    dimensions: [headlines.created_week]
    measures: [headlines.count]
    sorts: [headlines.count desc]
    hide_points: true
    stacking: ''
    x_axis_scale: auto
    interpolation: linear
    listen:
      time: headlines.created_week
    width: 12

  - name: usage_votes
    title: Daily Votes 
    type: looker_area
    base_view: votes
    dimensions: [votes.created_date]
    measures: [votes.count]
    hide_points: true
    stacking: ''
    x_axis_scale: auto
    interpolation: linear
    listen:
      time: headlines.created_date
    width: 12
    
  - name: usage_week_votes
    title: Weekly Votes 
    type: looker_area
    base_view: votes
    dimensions: [votes.created_week]
    measures: [votes.count]
    hide_points: true
    stacking: ''
    x_axis_scale: auto
    interpolation: linear
    listen:
      time: headlines.created_week
    width: 12

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
# 
#   - name: avg_karma_by_retention
#     title: Average Karma by Sign in Count
#     type: looker_column
#     base_view: users
#     dimensions: [users.sign_in_count_tier]
#     measures: [users.average_karma]
#     sorts: [users.sign_in_count_tier]
#     interpolation: monotone
#     hide_points: true
#     colors: green

  - name: most_smashed
    title: Top 50 Most Smashed Sources
    type: looker_column
    base_view: source_headline_fragments
    dimensions: [source_headlines.source_id]
    measures: [headlines.count]
    sorts: [headlines.count desc]
    limit: 50
    show_null_labels: false
    stacking: ''
    width: 12

  - name: sources
    title: Top 50 Sources
    type: looker_column
    base_view: source_headlines
    dimensions: [source_headlines.source_id]
    measures: [source_headlines.count]
    limit: 50
    width: 12
