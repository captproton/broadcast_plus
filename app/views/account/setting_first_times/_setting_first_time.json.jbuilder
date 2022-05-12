json.extract! setting_first_time,
  :id,
  :site_id,
  :first_name,
  :last_name,
  :blurb,
  :twitter_handle,
  :featured_image_src,
  :featured_youtube_video_url,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_setting_first_time_url(setting_first_time, format: :json)
