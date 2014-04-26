- view: votes
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at

  - dimension: headline_id
    type: int
    hidden: true
    sql: ${TABLE}.headline_id

  - dimension: ip
    sql: ${TABLE}.ip

  - dimension_group: updated
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updated_at

  - dimension: user_id
    type: int
    hidden: true
    sql: ${TABLE}.user_id

  - dimension: value
    type: int
    sql: ${TABLE}.value

  - measure: count
    type: count
    detail: detail*


  # ----- Detail ------
  sets:
    detail:
      - id
      - headlines.id
      - headlines.name
      - users.id

