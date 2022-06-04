json.extract! blog_entry,
  :id,
  :site_id,
  :title,
  :pinned_value,
  :publish_at,
  :seo_title,
  :seo_description,
  :hero_image,
  :image,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_blog_entry_url(blog_entry, format: :json)
