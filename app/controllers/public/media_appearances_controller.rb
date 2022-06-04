class Public::MediaAppearancesController < Public::CustomerSite::BaseController
  before_action :set_media_appearances_page
  layout "frontdoor"

  # GET /books
  # GET /books.json
  def index
    @media_appearances = @site.media_appearances
  end


  def set_media_appearances_page
    @media_appearances_page = @site.setting_media_appearances_pages.first
    @hero_image_url   = url_for(@media_appearances_page.hero_image)
  end

end
