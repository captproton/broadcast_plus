class Api::V1::ImageSerializer < Api::V1::ApplicationSerializer
  set_type "image"

  attributes :id,
    :site_id,
    :title,
    :image,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :site, serializer: Api::V1::SiteSerializer
end
