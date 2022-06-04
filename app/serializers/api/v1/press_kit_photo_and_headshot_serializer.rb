class Api::V1::PressKitPhotoAndHeadshotSerializer < Api::V1::ApplicationSerializer
  set_type "press_kit_photo_and_headshot"

  attributes :id,
    :setting_press_kit_id,
    :title,
    :description,
    :dimensions_wxh,
    :headshot_or_other,
    :publish_at,
    :photo,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :setting_press_kit, serializer: Api::V1::SettingPressKitSerializer
end
