json.extract! publisher_account,
  :id,
  :site_id,
  :name,
  :url,
  :font_awesome_class,
  :network_kind,
  :blurb,
  :svg_logo,
  :svg_logo_style,
  :frontpage_ranking,
  :sidebar_ranking,
  :footer_ranking,
  :podcast_ranking,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_publisher_account_url(publisher_account, format: :json)
