json.extract! setting_media_appearances_page,
  :id,
  :site_id,
  :hero_title,
  :hero_image,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_setting_media_appearances_page_url(setting_media_appearances_page, format: :json)
