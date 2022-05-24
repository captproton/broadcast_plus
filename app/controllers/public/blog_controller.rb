class Public::BlogController < Public::CustomerSite::BaseController
  include Pagy::Backend
  layout "frontdoor"

  def index
    if params[:tag]
      @blog_entries  = BlogEntry.published.tagged_with(params[:tag])
    else
      # @pagy, @blog_entries  = pagy(BlogEntry.published, items: 10)
      @blog_entries  = BlogEntry.published
    end
    @billboard_entry            = BlogEntry.featured.first
    @blog_featured_2nd_and_3rd  = BlogEntry.featured_2nd_and_3rd
    @sidebar_icons              = PublisherAccount.sidebar_icons.first(5)

  end
end
