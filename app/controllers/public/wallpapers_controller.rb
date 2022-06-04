class Public::WallpapersController < Public::CustomerSite::BaseController

  # GET /wallpapers
  # GET /wallpapers.json
  def index

    @wallpapers = @site.wallpapers.all
    render :layout => 'frontdoor'

  end

  # GET /wallpapers/1
  # GET /wallpapers/1.json
  def show
  end

end
