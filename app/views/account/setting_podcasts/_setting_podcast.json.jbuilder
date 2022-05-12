json.extract! setting_podcast,
  :id,
  :site_id,
  :hero_title,
  :hero_image,
  :title,
  :podcast_player_src,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_setting_podcast_url(setting_podcast, format: :json)