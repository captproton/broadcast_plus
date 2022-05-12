class Api::V1::MediaAppearanceSerializer < Api::V1::ApplicationSerializer
  set_type "media_appearance"

  attributes :id,
    :site_id,
    :title,
    :published_on,
    :article_url,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :site, serializer: Api::V1::SiteSerializer
end
