class Public::BooksController < Public::CustomerSite::BaseController
  before_action :set_book_collection_page
  layout "frontdoor"

  # GET /books
  # GET /books.json
  def index
    @books = @site.books
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  def set_book_collection_page
    @book_info    = @site.setting_book_collection_pages.first
    @hero_image_url   = url_for(@book_info.hero_image)
  end

end
