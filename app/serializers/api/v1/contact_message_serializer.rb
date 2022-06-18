class Api::V1::ContactMessageSerializer < Api::V1::ApplicationSerializer
  set_type "contact_message"

  attributes :id,
    :site_id,
    :email,
    :first_name,
    :last_name,
    :phone,
    :subject,
    :body,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :site, serializer: Api::V1::SiteSerializer
end
