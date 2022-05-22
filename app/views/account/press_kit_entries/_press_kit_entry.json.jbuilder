json.extract! press_kit_entry,
  :id,
  :setting_press_kit_id,
  :title,
  :article_link,
  :publish_on,
  :release_at,
  :article_image,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_press_kit_entry_url(press_kit_entry, format: :json)
