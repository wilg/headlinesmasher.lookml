- view: source_headlines
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at

  - dimension: name
    sql: ${TABLE}.name

  - dimension: hash
    sql: ${TABLE}.name_hash

  - dimension: fetcher
    sql: ${TABLE}.fetcher

  - dimension: source_id
    sql: ${TABLE}.source_id

#   - dimension_group: updated
#     type: time
#     timeframes: [time, date, week, month]
#     sql: ${TABLE}.updated_at
    
  - dimension_group: fetched
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updated_at

  - dimension: url
    sql: ${TABLE}.url

  - measure: count
    type: count
    detail: detail*


  # ----- Detail ------
  sets:
    detail:
      - name
      - id
        # Counters for views that join 'source_headlines'
      - source_headline_fragments.count
