class Api::V1::PressKitEntrySerializer < Api::V1::ApplicationSerializer
  set_type "press_kit_entry"

  attributes :id,
    :setting_press_kit_id,
    :title,
    :article_link,
    :publish_on,
    :release_at,
    :article_image,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :setting_press_kit, serializer: Api::V1::SettingPressKitSerializer
end
