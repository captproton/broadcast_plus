class Public::EventsController < Public::CustomerSite::BaseController
  before_action :set_events_page
  layout "frontdoor"

  # GET /books
  # GET /books.json
  def index
    @events = @upcoming_events
  end


  def set_events_page
    @event_page = @site.setting_event_pages.first
    @hero_image_url   = url_for(@event_page.hero_image)
  end

end
