json.extract! setting_general_info,
  :id,
  :site_id,
  :site_name,
  :plain_text_name,
  :text_number,
  :newsletter_subscription_url,
  :default_meta_blurb,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_setting_general_info_url(setting_general_info, format: :json)
