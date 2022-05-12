json.extract! setting_book_collection_page,
  :id,
  :site_id,
  :title,
  :hero_image,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_setting_book_collection_page_url(setting_book_collection_page, format: :json)
