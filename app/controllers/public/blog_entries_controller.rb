class Public::BlogEntriesController < Public::CustomerSite::BaseController
  def index
  end

  def show
    @blog_entry             = BlogEntry.find(params[:id])
    @blog_article           = @blog_entry.essay
    # sidebar
    @blog_list_title        = "blog-entry-aside"
    @recommended_entries    = BlogEntry.recommend_entries(@site, @blog_list_title)

  end

  def cosmo
  end

  def houston
  end
end
