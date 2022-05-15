json.extract! event,
  :id,
  :site_id,
  :title,
  :start_date,
  :finish_date,
  :more_info_url,
  :location,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_event_url(event, format: :json)
