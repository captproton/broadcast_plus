json.extract! wallpaper,
  :id,
  :site_id,
  :name,
  :title,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_wallpaper_url(wallpaper, format: :json)
