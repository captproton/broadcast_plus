class BlogCard < ApplicationRecord
  # 🚅 add concerns above.

  belongs_to :blog_list
  belongs_to :blog_entry
  # 🚅 add belongs_to associations above.

  # 🚅 add has_many associations above.

  # 🚅 add has_one associations above.

  # 🚅 add scopes above.

  validates :blog_entry, scope: true
  # 🚅 add validations above.

  # 🚅 add callbacks above.

  # 🚅 add delegations above.

  def valid_blog_entries
    blog_list.valid_blog_entries
  end

  # 🚅 add methods above.
end
