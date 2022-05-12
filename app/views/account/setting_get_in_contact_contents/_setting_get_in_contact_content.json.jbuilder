json.extract! setting_get_in_contact_content,
  :id,
  :site_id,
  :first_name,
  :last_name,
  :youtube_url,
  :youtube_image_url,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_setting_get_in_contact_content_url(setting_get_in_contact_content, format: :json)
