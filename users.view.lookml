- view: users
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension: api_key
    sql: ${TABLE}.api_key

  - dimension: api_requests
    type: int
    sql: ${TABLE}.api_requests

  - dimension: comments_count
    type: int
    sql: ${TABLE}.comments_count

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at

  - dimension_group: current_sign_in
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.current_sign_in_at

  - dimension: current_sign_in_ip
    sql: ${TABLE}.current_sign_in_ip

  - dimension: encrypted_password
    sql: ${TABLE}.encrypted_password

  - dimension: karma
    type: int
    sql: ${TABLE}.karma

  - dimension_group: last_sign_in
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_sign_in_at

  - dimension: last_sign_in_ip
    sql: ${TABLE}.last_sign_in_ip

  - dimension: login
    sql: ${TABLE}.login

  - dimension_group: remember_created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.remember_created_at

  - dimension: saved_headlines_count
    type: int
    sql: ${TABLE}.saved_headlines_count

  - dimension: sign_in_count
    type: int
    sql: ${TABLE}.sign_in_count

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
        # Counters for views that join 'users'
      - comments.count
      - votes.count

