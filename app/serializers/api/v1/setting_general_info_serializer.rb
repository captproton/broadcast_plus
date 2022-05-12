class Api::V1::SettingGeneralInfoSerializer < Api::V1::ApplicationSerializer
  set_type "setting_general_info"

  attributes :id,
    :site_id,
    :site_name,
    :plain_text_name,
    :text_number,
    :newsletter_subscription_url,
    :default_meta_blurb,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :site, serializer: Api::V1::SiteSerializer
end
