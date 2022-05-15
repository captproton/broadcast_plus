class Public::BlogController < Public::CustomerSite::BaseController
  include Pagy::Backend
  layout "frontdoor"

  def index
    if params[:tag]
      @blog_entries  = Blog::Entry.published.tagged_with(params[:tag])
    else
      @pagy, @blog_entries  = pagy(Blog::Entry.published, items: 10)
    end
    @billboard_entry            = Blog::Entry.featured.first
    @blog_featured_2nd_and_3rd  = Blog::Entry.featured_2nd_and_3rd
    @sidebar_icons              = PublisherAccount.sidebar_icons.first(5)

  end
end
