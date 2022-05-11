class BlogCard < ApplicationRecord
  belongs_to :blog_list
  belongs_to :blog_entry
end
