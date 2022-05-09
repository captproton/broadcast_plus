json.extract! book,
  :id,
  :site_id,
  :title,
  :byline,
  :description,
  :jacket_url,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_book_url(book, format: :json)
