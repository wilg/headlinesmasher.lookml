- view: source_words
  derived_table:
    sql: |
       
        SELECT 
          unnest(
            string_to_array(
              regexp_replace(lower(source_headlines.name), '[^a-zA-Z0-9 ]+', '', 'g')
            , ' ')
          ) as "word",
          source_headlines.id as source_headline_id
        FROM source_headlines
      
      
# WITH words AS
#       SELECT DISTINCT
#         word as word,
#         COUNT(*) as count
#       FROM WORDS 
#       GROUP BY 1
#       ORDER BY 2 DESC
      
#     persist_for: 24 hours
#     indexes: word
    
  fields:

    - dimension: word
      sql: ${TABLE}.word

    - dimension: source_headline_id
      sql: ${TABLE}.source_headline_id
      hidden: true
        
    - measure: count
      type: count
  