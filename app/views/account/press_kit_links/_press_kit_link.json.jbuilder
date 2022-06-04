json.extract! press_kit_link,
  :id,
  :setting_press_kit_id,
  :label,
  :url,
  :category,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_press_kit_link_url(press_kit_link, format: :json)
