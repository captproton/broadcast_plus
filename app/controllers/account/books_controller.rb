class Account::BooksController < Account::ApplicationController
  account_load_and_authorize_resource :book, through: :site, through_association: :books

  # GET /account/sites/:site_id/books
  # GET /account/sites/:site_id/books.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @site]
  end

  # GET /account/books/:id
  # GET /account/books/:id.json
  def show
  end

  # GET /account/sites/:site_id/books/new
  def new
  end

  # GET /account/books/:id/edit
  def edit
  end

  # POST /account/sites/:site_id/books
  # POST /account/sites/:site_id/books.json
  def create
    respond_to do |format|
      if @book.save
        format.html { redirect_to [:account, @site, :books], notice: I18n.t("books.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @book] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/books/:id
  # PATCH/PUT /account/books/:id.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to [:account, @book], notice: I18n.t("books.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @book] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/books/:id
  # DELETE /account/books/:id.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @site, :books], notice: I18n.t("books.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def book_params
    strong_params = params.require(:book).permit(
      :title,
      :byline,
      :description,
      :jacket_url,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
