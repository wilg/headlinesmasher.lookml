- dashboard: fetchers
  title: Fetchers
  layout: grid
  rows:
    - height: 300
      elements: [import_speed]
    - height: 300
      elements: [import_speed_2]
    - height: 200
      elements: [source_headlines]

  filters:

    - name: hourly
      title: "Hourly Timespan"
      type: date_filter
      default_value: Last 24 hours
      
    - name: daily
      title: "Monthly Timespan"
      type: date_filter
      default_value: Last 3 months
      
  elements:
    
    - name: import_speed
      title: Added Source Headlines
      type: looker_area
      base_view: source_headlines
      dimensions: [source_headlines.created_hour]
      measures: [source_headlines.count]
      sorts: [source_headlines.count desc]
      listen:
        hourly: source_headlines.created_date
      hide_points: true
      interpolation: monotone
      width: 12
      height: 4

    - name: import_speed_2
      title: Added Source Headlines
      type: looker_area
      base_view: source_headlines
      dimensions: [source_headlines.created_date]
      measures: [source_headlines.count]
      sorts: [source_headlines.count desc]
      listen:
        daily: source_headlines.created_date
      hide_points: true
      interpolation: monotone
      width: 12
      height: 4

    - name: source_headlines
      title: Source Headlines
      type: single_value
      base_view: source_headlines
      measures: [source_headlines.count]
      height: 2
      listen:
        date: source_headlines.created_date
      width: 4
