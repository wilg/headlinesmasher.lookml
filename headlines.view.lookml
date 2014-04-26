- view: headlines
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension: bot_share_tweet_id
    sql: ${TABLE}.bot_share_tweet_id

  - dimension_group: bot_shared
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.bot_shared_at

  - dimension: comments_count
    type: int
    sql: ${TABLE}.comments_count

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at

  - dimension: creator_id
    type: int
    sql: ${TABLE}.creator_id

  - dimension: depth
    type: int
    sql: ${TABLE}.depth

  - dimension: name
    sql: ${TABLE}.name

  - dimension: name_hash
    sql: ${TABLE}.name_hash

  - dimension: photo_data
    sql: ${TABLE}.photo_data

  - dimension: source_names
    sql: ${TABLE}.source_names

  - dimension_group: updated
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updated_at

  - dimension: vote_count
    type: int
    sql: ${TABLE}.vote_count

  - measure: count
    type: count
    detail: detail*


  # ----- Detail ------
  sets:
    detail:
      - id
      - name
        # Counters for views that join 'headlines'
      - comments.count
      - source_headline_fragments.count
      - votes.count

