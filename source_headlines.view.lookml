- view: source_headlines
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month, hour]
    sql: ${TABLE}.created_at

  - dimension: name
    sql: ${TABLE}.name

  - dimension: hash
    sql: ${TABLE}.name_hash

  - dimension: fetcher
    sql: ${TABLE}.fetcher

  - dimension: source_id
    sql: ${TABLE}.source_id

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
    timeframes: [time, date, week, month]
    sql: ${TABLE}.published_at

  - dimension: url
    sql: ${TABLE}.url

  - dimension: permalink
    sql: ${TABLE}.id
    html: |
      <a href="http://headlinesmasher.com/source_headlines/<%= value %>">View</a>
      
  - dimension: article_link
    sql: ${TABLE}.url
    html: |
      <% if value %><a href="<%= value %>">Read</a><% else %>&empty;<% end %>
      
  - measure: count
    type: count
    drill_fields: detail*

    
  # ----- Detail ------
  sets:
    drill_fields:
      - name
      - id
        # Counters for views that join 'source_headlines'
      - source_headline_fragments.count