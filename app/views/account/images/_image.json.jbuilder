json.extract! image,
  :id,
  :site_id,
  :title,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_image_url(image, format: :json)
