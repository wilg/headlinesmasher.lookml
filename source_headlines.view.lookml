- view: source_headlines
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id
    links:
      - label: View Source Headline
        url: https://www.headlinesmasher.com/source_headlines/{{ value }}
        icon_url: https://d260rnacdi07m9.cloudfront.net/assets/favicon-eb8ca42b49f74ee792fca554f7b8b4c5.ico

  - dimension_group: created
    type: time
    sql: ${TABLE}.created_at

  - dimension: name
    sql: ${TABLE}.name
    links:
      - label: View Source Headline
        url: https://www.headlinesmasher.com/source_headlines/{{ source_headlines.id._value }}
        icon_url: https://d260rnacdi07m9.cloudfront.net/assets/favicon-eb8ca42b49f74ee792fca554f7b8b4c5.ico
      - label: Read Article
        url: "{{ source_headlines.url._value }}"

  - dimension: hash
    sql: ${TABLE}.name_hash

  - dimension: fetcher
    sql: ${TABLE}.fetcher

  - dimension: source_id
    sql: ${TABLE}.source_id
    links:
      - label: View Source
        url: https://www.headlinesmasher.com/sources/{{ value }}
        icon_url: https://d260rnacdi07m9.cloudfront.net/assets/favicon-eb8ca42b49f74ee792fca554f7b8b4c5.ico

  - dimension: author
    sql: ${TABLE}.author

  - dimension: section
    sql: ${TABLE}.section

#   - dimension_group: updated
#     type: time
#     timeframes: [time, date, week, month]
#     sql: ${TABLE}.updated_at
    
  - dimension_group: published
    type: time
    sql: ${TABLE}.published_at

  - dimension: url
    sql: ${TABLE}.url

  - measure: count
    type: count
    drill_fields: detail*

    
  # ----- Detail ------
  sets:
    detail:
      - created_at
      - source_id
      - name
        # Counters for views that join 'source_headlines'
      - source_headline_fragments.count