class Api::V1::SiteSerializer < Api::V1::ApplicationSerializer
  set_type "site"

  attributes :id,
    :team_id,
    :name,
    :subdomain,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :team, serializer: Api::V1::TeamSerializer
end
