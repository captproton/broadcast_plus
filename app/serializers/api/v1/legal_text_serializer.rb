class Api::V1::LegalTextSerializer < Api::V1::ApplicationSerializer
  set_type "legal_text"

  attributes :id,
    :site_id,
    :title,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :site, serializer: Api::V1::SiteSerializer
end
