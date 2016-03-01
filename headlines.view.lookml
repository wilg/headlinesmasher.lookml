- view: headlines
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id
 
  - dimension: creator_id
    hidden: true
    type: number
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
    type: number
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

  - dimension: number_of_retweets
    type: number
    sql: ${TABLE}.retweet_count
    
  - dimension: number_of_favorites
    type: number
    sql: ${TABLE}.favorite_count
    
  - dimension: number_of_mentions
    type: number
    sql: ${TABLE}.mention_count
    
  - dimension: number_of_twitter_engagements
    type: number
    sql: ${number_of_retweets} + ${number_of_favorites} + ${number_of_mentions}
    
  - dimension: score
    type: number
    sql: COALESCE(${TABLE}.score, ${number_of_votes})

#   - dimension: photo_data
#     sql: ${TABLE}.photo_data

#   - dimension: source_names
#     sql: ${TABLE}.source_names

  - dimension_group: updated
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updated_at

  - dimension: number_of_votes
    type: number
    sql: ${TABLE}.vote_count

  - measure: count
    type: count
    drill_fields: detail*
    
  - measure: average_vote_count
    type: average
    value_format_name: decimal_1
    drill_fields: detail*
    sql: ${number_of_votes}

  - measure: total_vote_count
    type: sum
    drill_fields: detail*
    sql: ${number_of_votes}

  - measure: total_retweets
    type: sum
    drill_fields: detail*
    sql: ${number_of_retweets}

  - measure: total_favorites
    type: sum
    drill_fields: detail*
    sql: ${number_of_favorites}

  - measure: total_twitter_engagements
    type: sum
    drill_fields: detail*
    sql: ${number_of_twitter_engagements}

  - measure: average_retweets
    type: average
    value_format_name: decimal_1
    drill_fields: detail*
    sql: ${number_of_retweets}

  - measure: average_favorites
    type: average
    value_format_name: decimal_1
    drill_fields: detail*
    sql: ${number_of_favorites}

  - measure: average_twitter_engagements
    type: average
    value_format_name: decimal_1
    drill_fields: detail*
    sql: ${number_of_twitter_engagements}

  # ----- Detail ------
  sets:
    detail:
      - id
      - headline
      - number_of_votes
      - bot_tweeted
        # Counters for views that join 'headlines'
      - comments.count
      - source_headline_fragments.count
      - votes.count