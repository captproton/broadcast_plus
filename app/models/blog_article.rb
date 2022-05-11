class BlogArticle < ApplicationRecord
  # 🚅 add concerns above.

  belongs_to :blog_entry
  # 🚅 add belongs_to associations above.

  # 🚅 add has_many associations above.

  has_one :team, through: :blog_entry
  has_rich_text :body
  # 🚅 add has_one associations above.

  # 🚅 add scopes above.

  validates :pinned_value, presence: true
  # 🚅 add validations above.

  # 🚅 add callbacks above.

  # 🚅 add delegations above.

  # 🚅 add methods above.
end
