class PressKitLink < ApplicationRecord
  # 🚅 add concerns above.

  belongs_to :setting_press_kit
  # 🚅 add belongs_to associations above.

  # 🚅 add has_many associations above.

  has_one :team, through: :setting_press_kit
  # 🚅 add has_one associations above.
  scope :social,     -> { where("category = ?", "Social"||"social")}
  scope :website,     -> { where("category = ?", "Website"||"website")}
  scope :company,     -> { where("category = ?", "Company"||"company")}
  # 🚅 add scopes above.

  validates :label, presence: true
  # 🚅 add validations above.

  # 🚅 add callbacks above.

  # 🚅 add delegations above.

  # 🚅 add methods above.
end
