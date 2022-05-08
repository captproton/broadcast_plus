class Account::MerchandiseLinksController < Account::ApplicationController
  account_load_and_authorize_resource :merchandise_link, through: :book, through_association: :merchandise_links

  # GET /account/books/:book_id/merchandise_links
  # GET /account/books/:book_id/merchandise_links.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @book]
  end

  # GET /account/merchandise_links/:id
  # GET /account/merchandise_links/:id.json
  def show
  end

  # GET /account/books/:book_id/merchandise_links/new
  def new
  end

  # GET /account/merchandise_links/:id/edit
  def edit
  end

  # POST /account/books/:book_id/merchandise_links
  # POST /account/books/:book_id/merchandise_links.json
  def create
    respond_to do |format|
      if @merchandise_link.save
        format.html { redirect_to [:account, @book, :merchandise_links], notice: I18n.t("merchandise_links.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @merchandise_link] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @merchandise_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/merchandise_links/:id
  # PATCH/PUT /account/merchandise_links/:id.json
  def update
    respond_to do |format|
      if @merchandise_link.update(merchandise_link_params)
        format.html { redirect_to [:account, @merchandise_link], notice: I18n.t("merchandise_links.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @merchandise_link] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @merchandise_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/merchandise_links/:id
  # DELETE /account/merchandise_links/:id.json
  def destroy
    @merchandise_link.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @book, :merchandise_links], notice: I18n.t("merchandise_links.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def merchandise_link_params
    strong_params = params.require(:merchandise_link).permit(
      :seller_name,
      :item_url,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
