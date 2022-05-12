json.extract! blog_list,
  :id,
  :site_id,
  :title,
  :description,
  :tag_ids,
  :blog_entry_ids,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_blog_list_url(blog_list, format: :json)
