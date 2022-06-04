json.extract! blog_article,
  :id,
  :blog_entry_id,
  :byline,
  :pinned_value,
  :name,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_blog_article_url(blog_article, format: :json)
