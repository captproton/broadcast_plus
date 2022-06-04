class Api::V1::BlogArticleSerializer < Api::V1::ApplicationSerializer
  set_type "blog_article"

  attributes :id,
    :blog_entry_id,
    :byline,
    :pinned_value,
    :name,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :blog_entry, serializer: Api::V1::BlogEntrySerializer
end
