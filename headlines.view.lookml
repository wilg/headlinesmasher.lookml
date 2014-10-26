- view: headlines
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id
 
  - dimension: creator_id
    hidden: true
    type: int
    sql: ${TABLE}.creator_id

  - dimension: bot_tweet_url
    sql: ${TABLE}.bot_share_tweet_id
    html: |
      <a href="https://twitter.com/HeadlineSmasher/status/{{ value }}">View Tweet</a>
      
  - dimension: bot_tweeted
    type: yesno
    sql: ${TABLE}.bot_share_tweet_id is not null

  - dimension: permalink_url
    sql: ${TABLE}.id
    html: |
      <a href="http://headlinesmasher.com/headlines/{{ value }}">View on Headline Smasher</a>

  - dimension_group: bot_tweeted
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.bot_shared_at

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at

  - dimension: depth
    type: int
    sql: ${TABLE}.depth

  - dimension: headline
    sql: ${TABLE}.name

  - dimension: name_hash
    sql: ${TABLE}.name_hash
    
  - dimension: word_count
    type: number
    sql: array_length(string_to_array(${headline}, ' '), 1)
    
  - dimension: character_count
    type: number
    sql: character_length(${headline})

#   - dimension: photo_data
#     sql: ${TABLE}.photo_data

#   - dimension: source_names
#     sql: ${TABLE}.source_names

  - dimension_group: updated
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updated_at

#   - dimension: vote_count
#     type: int
#     sql: ${TABLE}.vote_count

  - measure: count
    type: count
    drill_fields: detail*
    
  - measure: average_vote_count
    type: average
    drill_fields: detail*
    sql: ${TABLE}.vote_count

  - measure: total_vote_count
    type: sum
    drill_fields: detail*
    sql: ${TABLE}.vote_count


  # ----- Detail ------
  sets:
    detail:
      - id
      - name
        # Counters for views that join 'headlines'
      - comments.count
      - source_headline_fragments.count
      - votes.count