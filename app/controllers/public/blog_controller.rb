class Public::BlogController < Public::CustomerSite::BaseController
  include Pagy::Backend
  layout "frontdoor"

  def index
    if params[:tag]
      @blog_list = @site.blog_lists.find_by("title = ?", params[:tag])
      @blog_entries = @blog_list.blog_entries.published
      @entries = @blog_entries
      @aside_entry_recommendations = BlogEntry.recommendation_collection("front-door-aside")
    else
      # @pagy, @blog_entries  = pagy(@site.blog_entrie.published, items: 10)
      @blog_entries  = @site.blog_entries.published
      # @blog_entries  = pagy(@site.blog_entries.published, items: 10)
    end
    @billboard_entry            = BlogEntry.featured.first
    @blog_featured_2nd_and_3rd  = BlogEntry.featured_2nd_and_3rd
    # sidebar
    @blog_list_title       = "blog-index-aside"
    @recommended_entries  = BlogEntry.recommend_entries(@site, @blog_list_title)
    
    @sidebar_icons              = PublisherAccount.sidebar_icons(@site).first(5)

  end
end
