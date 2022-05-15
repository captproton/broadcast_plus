class Public::MediaAppearancesController < Public::CustomerSite::BaseController
  before_action :set_media_appearances_page
  layout "frontdoor"

  # GET /books
  # GET /books.json
  def index
    @media_appearances = @site.media_appearances
  end


  def set_media_appearances_page
    @event_page = @site.setting_event_pages.first
    @hero_image_url   = url_for(@event_page.hero_image)
  end

end
