- dashboard: stats
  title: "Stats"
  layout: tile
  tile_size: 100

  elements:

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
