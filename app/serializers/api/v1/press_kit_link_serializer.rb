class Api::V1::PressKitLinkSerializer < Api::V1::ApplicationSerializer
  set_type "press_kit_link"

  attributes :id,
    :setting_press_kit_id,
    :label,
    :url,
    :category,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :setting_press_kit, serializer: Api::V1::SettingPressKitSerializer
end
