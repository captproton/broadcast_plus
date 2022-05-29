class Public::BlogEntriesController < Public::CustomerSite::BaseController
  def index
  end

  def show
    @blog_entry             = BlogEntry.find(params[:id])
    @blog_article           = @blog_entry.essay
    @blog_recommendations   = BlogEntry.recommend_entries(@site, "blog-entry-aside")
  end

  def cosmo
  end

  def houston
  end
end
