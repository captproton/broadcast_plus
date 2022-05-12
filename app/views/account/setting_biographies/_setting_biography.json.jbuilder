json.extract! setting_biography,
  :id,
  :site_id,
  :title,
  :hero_image,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_setting_biography_url(setting_biography, format: :json)
