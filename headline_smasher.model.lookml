- connection: headline_smasher

# test

- scoping: true                  # for backward compatibility
- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- explore: comments
  joins:
    - join: headlines
      foreign_key: headline_id

    - join: users
      foreign_key: user_id

- explore: headlines
  joins:
    - join: users
      foreign_key: creator_id

- explore: source_headline_fragments
  joins:
    - join: source_headlines
      foreign_key: source_headline_id

    - join: headlines
      foreign_key: headline_id

- explore: source_headlines
  joins:
    - join: sources
      foreign_key: source_id

- explore: source_words
  joins:
    - join: source_headlines
      foreign_key: source_headline_id

- explore: users
- explore: sources

- explore: votes
  joins:
    - join: headlines
      foreign_key: headline_id

    - join: users
      foreign_key: user_id


