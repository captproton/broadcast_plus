json.extract! setting_event_page,
  :id,
  :site_id,
  :hero_title,
  :hero_image,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_setting_event_page_url(setting_event_page, format: :json)
