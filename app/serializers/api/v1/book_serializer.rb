class Api::V1::BookSerializer < Api::V1::ApplicationSerializer
  set_type "book"

  attributes :id,
    :site_id,
    :title,
    :byline,
    :description,
    :jacket_url,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :site, serializer: Api::V1::SiteSerializer
end
