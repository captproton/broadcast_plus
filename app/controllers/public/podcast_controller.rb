class Public::PodcastController < Public::CustomerSite::BaseController
  before_action :set_podcast_page
  layout "frontdoor"

  # GET /books
  # GET /books.json
  def index
    # @ = @site.events
  end


  def set_podcast_page
    @podcast_page = @site.setting_podcast_pages.first
    @hero_image_url   = url_for(@podcast_page.hero_image)
    @site_general_info = @site.setting_general_infos.first
  end

end
