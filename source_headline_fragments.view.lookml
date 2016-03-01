- view: source_headline_fragments
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at

  - dimension: headline_id
    type: number
    hidden: true
    sql: ${TABLE}.headline_id

  - dimension: index
    type: number
    sql: ${TABLE}.index

  - dimension: source_headline_end
    type: number
    sql: ${TABLE}.source_headline_end

  - dimension: source_headline_id
    type: number
    hidden: true
    sql: ${TABLE}.source_headline_id

  - dimension: source_headline_start
    type: number
    sql: ${TABLE}.source_headline_start

  - dimension_group: updated
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updated_at

  - measure: count
    type: count
    drill_fields: detail*


  # ----- Detail ------
  sets:
    detail:
      - id
      - source_headlines.name
      - source_headlines.id
      - headlines.id
      - headlines.name