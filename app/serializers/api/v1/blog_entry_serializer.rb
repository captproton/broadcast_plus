class Api::V1::BlogEntrySerializer < Api::V1::ApplicationSerializer
  set_type "blog_entry"

  attributes :id,
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

  belongs_to :site, serializer: Api::V1::SiteSerializer
end
