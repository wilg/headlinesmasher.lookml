- view: headlines
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id
    links:
      - label: View Headline
        url: https://www.headlinesmasher.com/{{ value }}
        icon_url: https://d260rnacdi07m9.cloudfront.net/assets/favicon-eb8ca42b49f74ee792fca554f7b8b4c5.ico
 
  - dimension: headline
    sql: ${TABLE}.name
    links:
      - label: View Headline
        url: https://www.headlinesmasher.com/{{ headlines.id._value }}
        icon_url: https://d260rnacdi07m9.cloudfront.net/assets/favicon-eb8ca42b49f74ee792fca554f7b8b4c5.ico
      - label: View Tweet
        url: |
          {% if headlines.bot_tweet_url._value %}
            https://twitter.com/HeadlineSmasher/status/{{ headlines.bot_tweet_url._value }}
          {% endif %}
        icon_url: http://twitter.com/favicon.ico

  - dimension: creator_id
    hidden: true
    type: number
    sql: ${TABLE}.creator_id

  - dimension: bot_tweet_url
    sql: ${TABLE}.bot_share_tweet_id
    hidden: false
    links:
      - label: View Tweet
        url: |
          {% if value %}
            https://twitter.com/HeadlineSmasher/status/{{ value }}
          {% endif %}
        icon_url: http://twitter.com/favicon.ico

  - dimension: bot_tweeted
    type: yesno
    sql: ${TABLE}.bot_share_tweet_id is not null

  - dimension_group: bot_tweeted
    type: time
    sql: ${TABLE}.bot_shared_at

  - dimension_group: created
    type: time
    sql: ${TABLE}.created_at

  - dimension: depth
    type: number
    sql: ${TABLE}.depth

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
    hidden: true
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
      - headline
      - number_of_votes
      - bot_tweeted
        # Counters for views that join 'headlines'
      - comments.count
      - source_headline_fragments.count
      - votes.count