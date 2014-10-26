- view: sources
  derived_table:
    sql: |
      SELECT 
        c.source_id AS "source_id",
        ( SELECT created_at 
          FROM source_headlines 
          WHERE source_headlines.source_id = c.source_id
          ORDER BY created_at desc
          LIMIT 1
        ) as last_updated_at
      FROM source_headlines AS c
      
      GROUP BY 1
      LIMIT 500
#     sql_trigger_value: |
#       SELECT created_at 
#       FROM source_headlines 
#       ORDER BY created_at desc
#       LIMIT 1
#     indexes: source_id
    
  fields:
  
    - dimension: id
      sql: ${TABLE}.source_id
      primary_key: true
  
    - dimension_group: fetched
      type: time
      timeframes: [time, date, week, month]
      sql: ${TABLE}.last_updated_at
      
    - measure: count
      type: count
      drill_fields: detail*
  
    - measure: source_list
      type: list
      list_field: id
  
  sets:
    detail:
      - source_id
      - last_updated_at

