class Api::V1::EventSerializer < Api::V1::ApplicationSerializer
  set_type "event"

  attributes :id,
    :site_id,
    :title,
    :start_date,
    :more_info_url,
    :location,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :site, serializer: Api::V1::SiteSerializer
end
