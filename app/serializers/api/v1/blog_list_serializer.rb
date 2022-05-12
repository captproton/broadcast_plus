class Api::V1::BlogListSerializer < Api::V1::ApplicationSerializer
  set_type "blog_list"

  attributes :id,
    :site_id,
    :title,
    :description,
    :tag_ids,
    :blog_entry_ids,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :site, serializer: Api::V1::SiteSerializer
end
