json.extract! setting_first_time,
  :id,
  :site_id,
  :hero_title,
  :hero_image,
  :first_name,
  :last_name,
  :featured_aside_image,
  :blurb,
  :twitter_handle,
  :featured_youtube_video_url,
  :youtube_video_poster_photo_url,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_setting_first_time_url(setting_first_time, format: :json)
