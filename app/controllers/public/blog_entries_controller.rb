class Public::BlogEntriesController < Public::CustomerSite::BaseController
  def index
  end

  def show
    @blog_entry = BlogEntry.find(params[:id])
  end

  def cosmo
  end

  def houston
  end
end
