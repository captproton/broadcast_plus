json.extract! setting_press_kit,
  :id,
  :site_id,
  :hero_title,
  :hero_image,
  :name,
  :birthplace,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_setting_press_kit_url(setting_press_kit, format: :json)
