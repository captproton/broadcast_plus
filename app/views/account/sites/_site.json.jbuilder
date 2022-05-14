json.extract! site,
  :id,
  :team_id,
  :name,
  :subdomain,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_site_url(site, format: :json)
