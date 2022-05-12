json.extract! setting_home_info,
  :id,
  :site_id,
  :biography_blurb,
  :video_billboard_url,
  :watch_this_video_url,
  :bio_link_label,
  :watch_this_poster_url,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_setting_home_info_url(setting_home_info, format: :json)
