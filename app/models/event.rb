class Event < ApplicationRecord
  # 🚅 add concerns above.

  belongs_to :site
  # 🚅 add belongs_to associations above.

  # 🚅 add has_many associations above.

  has_one :team, through: :site
  # 🚅 add has_one associations above.
  scope :coming_soon, -> { where('start_date >= ?',  Date.today).order("start_date ASC").first(5)}
  # Ex:- scope :active, -> {where(:active => true)}
  # 🚅 add scopes above.

  validates :title, presence: true
  # 🚅 add validations above.

  # 🚅 add callbacks above.

  # 🚅 add delegations above.

  # 🚅 add methods above.
end
