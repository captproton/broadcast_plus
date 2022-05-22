json.extract! press_kit_photo_and_headshot,
  :id,
  :setting_press_kit_id,
  :title,
  :description,
  :dimensions_wxh,
  :headshot_or_other,
  :publish_at,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_press_kit_photo_and_headshot_url(press_kit_photo_and_headshot, format: :json)
