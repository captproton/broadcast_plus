json.extract! newsletter,
  :id,
  :site_id,
  :title,
  :mailing_group,
  :sender,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_newsletter_url(newsletter, format: :json)
