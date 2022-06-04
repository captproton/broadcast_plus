class PressKitEntry < ApplicationRecord
  # 🚅 add concerns above.

  belongs_to :setting_press_kit
  # 🚅 add belongs_to associations above.

  # 🚅 add has_many associations above.

  has_one :team, through: :setting_press_kit
  has_one_attached :article_image
  # 🚅 add has_one associations above.

  # 🚅 add scopes above.

  validates :title, presence: true
  # 🚅 add validations above.

  # 🚅 add callbacks above.

  # 🚅 add delegations above.

  # 🚅 add methods above.
end
