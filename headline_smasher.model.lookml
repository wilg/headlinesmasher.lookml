- connection: headline_smasher

# test

- scoping: true                  # for backward compatibility
- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- base_view: comments
  joins:
    - join: headlines
      foreign_key: headline_id

    - join: users
      foreign_key: user_id

- base_view: headlines
  joins:
    - join: users
      foreign_key: creator_id

- base_view: source_headline_fragments
  joins:
    - join: source_headlines
      foreign_key: source_headline_id

    - join: headlines
      foreign_key: headline_id

- base_view: source_headlines

- base_view: users

- base_view: votes
  joins:
    - join: headlines
      foreign_key: headline_id

    - join: users
      foreign_key: user_id


