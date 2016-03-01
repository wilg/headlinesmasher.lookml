- view: users
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: sign_in_count_tier
    type: tier
    tiers: [0,1,2,5,10]
    sql: ${sign_in_count}
  
  - dimension: api_requests
    type: number
    sql: ${TABLE}.api_requests

  - dimension: comments_count
    type: number
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

  - dimension: karma
    type: number
    sql: ${TABLE}.karma

  - dimension_group: last_sign_in
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_sign_in_at

  - dimension: last_sign_in_ip
    sql: ${TABLE}.last_sign_in_ip

  - dimension: login
    sql: ${TABLE}.login

#   - dimension_group: remember_created
#     type: time
#     timeframes: [time, date, week, month]
#     sql: ${TABLE}.remember_created_at

  - dimension: saved_headlines_count
    type: number
    sql: ${TABLE}.saved_headlines_count

  - dimension: sign_in_count
    type: number
    sql: ${TABLE}.sign_in_count

  - dimension_group: updated
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updated_at

  - dimension: vote_count
    type: number
    sql: ${TABLE}.vote_count

  - measure: count
    type: count
    drill_fields: detail*

  - measure: total_karma
    type: sum
    sql: ${TABLE}.karma

  - measure: average_karma
    type: average
    sql: ${TABLE}.karma


  # ----- Detail ------
  sets:
    detail:
      - id
        # Counters for views that join 'users'
      - comments.count
      - votes.count