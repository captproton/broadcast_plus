json.extract! merchandise_link,
  :id,
  :book_id,
  :seller_name,
  :item_url,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_merchandise_link_url(merchandise_link, format: :json)
