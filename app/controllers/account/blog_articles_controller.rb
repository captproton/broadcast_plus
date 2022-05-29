class Account::BlogArticlesController < Account::ApplicationController
  account_load_and_authorize_resource :blog_article, through: :blog_entry, through_association: :blog_articles

  # GET /account/blog_entries/:blog_entry_id/blog_articles
  # GET /account/blog_entries/:blog_entry_id/blog_articles.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @blog_entry]
  end

  # GET /account/blog_articles/:id
  # GET /account/blog_articles/:id.json
  def show
  end

  # GET /account/blog_entries/:blog_entry_id/blog_articles/new
  def new
  end

  # GET /account/blog_articles/:id/edit
  def edit
  end

  # POST /account/blog_entries/:blog_entry_id/blog_articles
  # POST /account/blog_entries/:blog_entry_id/blog_articles.json
  def create
    respond_to do |format|
      if @blog_article.save
        format.html { redirect_to [:account, @blog_entry, :blog_articles], notice: I18n.t("blog_articles.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @blog_article] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/blog_articles/:id
  # PATCH/PUT /account/blog_articles/:id.json
  def update
    respond_to do |format|
      if @blog_article.update(blog_article_params)
        format.html { redirect_to [:account, @blog_article], notice: I18n.t("blog_articles.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @blog_article] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/blog_articles/:id
  # DELETE /account/blog_articles/:id.json
  def destroy
    @blog_article.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @blog_entry, :blog_articles], notice: I18n.t("blog_articles.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def blog_article_params
    strong_params = params.require(:blog_article).permit(
      :byline,
      :pinned_value,
      :body,
      :name,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
