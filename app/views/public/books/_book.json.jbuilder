json.extract! book, :id, :title, :byline, :description, :created_at, :updated_at
json.url book_url(book, format: :json)
