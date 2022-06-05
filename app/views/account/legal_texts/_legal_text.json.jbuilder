json.extract! legal_text,
  :id,
  :site_id,
  :title,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_legal_text_url(legal_text, format: :json)
