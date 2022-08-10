class Api::V1::NewsletterSerializer < Api::V1::ApplicationSerializer
  set_type "newsletter"

  attributes :id,
    :site_id,
    :title,
    :mailing_group,
    :sender,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :site, serializer: Api::V1::SiteSerializer
end
