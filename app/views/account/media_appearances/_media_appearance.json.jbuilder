json.extract! media_appearance,
  :id,
  :site_id,
  :title,
  :published_on,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_media_appearance_url(media_appearance, format: :json)
