class Api::V1::BiographySerializer < Api::V1::ApplicationSerializer
  set_type "biography"

  attributes :id,
    :site_id,
    :title,
    :header_photo_url,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :site, serializer: Api::V1::SiteSerializer
end
