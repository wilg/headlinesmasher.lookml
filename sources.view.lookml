- view: sources
  derived_table:
    sql: |
      SELECT 
        c.id AS "source_id",
        c.json AS json,
        ( SELECT created_at 
          FROM source_headlines 
          WHERE source_headlines.source_id = c.id
          ORDER BY created_at desc
          LIMIT 1
        ) as last_updated_at
      FROM sources AS c
    persist_for: 5 minutes
    indexes: source_id
    
  fields:
  
    - dimension: id
      sql: ${TABLE}.source_id
      primary_key: true
      links:
      - label: View Source
        url: https://www.headlinesmasher.com/sources/{{ value }}
        icon_url: https://d260rnacdi07m9.cloudfront.net/assets/favicon-eb8ca42b49f74ee792fca554f7b8b4c5.ico

    - dimension: json
      sql: ${TABLE}.json
      hidden: true
  
    - dimension: name
      sql: ${json}->>'name'
      links:
      - label: View Source
        url: https://www.headlinesmasher.com/sources/{{ sources.id._value }}
        icon_url: https://d260rnacdi07m9.cloudfront.net/assets/favicon-eb8ca42b49f74ee792fca554f7b8b4c5.ico

    - dimension: category
      sql: ${json}->>'category'
  
    - dimension: default
      type: yesno
      sql: ${json}->>'default' = 'true'
  
    - dimension: dead
      type: yesno
      sql: ${json}->>'dead' = 'true'

    - dimension_group: fetched
      type: time
      sql: ${TABLE}.last_updated_at
      
    - measure: count
      type: count
      drill_fields: detail*
  
    - measure: source_list
      type: list
      list_field: name
  
    - measure: category_list
      type: list
      list_field: category
  
  sets:
    detail:
      - source_id
      - last_updated_at