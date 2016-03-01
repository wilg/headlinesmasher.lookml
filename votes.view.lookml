- view: votes
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

  - dimension: ip
    sql: ${TABLE}.ip

  - dimension_group: updated
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updated_at

  - dimension: user_id
    type: number
    hidden: true
    sql: ${TABLE}.user_id

  - dimension: value
    type: number
    sql: ${TABLE}.value

  - measure: count
    type: count
    drill_fields: detail*
    
  - measure: votes_per_headline
    type: number
    sql: ${votes.count}::float / NULLIF(${headlines.count}::float, 1)
    value_format_name: decimal_2


  # ----- Detail ------
  sets:
    detail:
      - id
      - headlines.id
      - headlines.name
      - users.id