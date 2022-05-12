json.extract! biography,
  :id,
  :site_id,
  :title,
  :header_photo_url,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_biography_url(biography, format: :json)
