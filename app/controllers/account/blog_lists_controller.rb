class Account::BlogListsController < Account::ApplicationController
  account_load_and_authorize_resource :blog_list, through: :site, through_association: :blog_lists

  # GET /account/sites/:site_id/blog_lists
  # GET /account/sites/:site_id/blog_lists.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @site]
  end

  # GET /account/blog_lists/:id
  # GET /account/blog_lists/:id.json
  def show
  end

  # GET /account/sites/:site_id/blog_lists/new
  def new
  end

  # GET /account/blog_lists/:id/edit
  def edit
  end

  # POST /account/sites/:site_id/blog_lists
  # POST /account/sites/:site_id/blog_lists.json
  def create
    respond_to do |format|
      if @blog_list.save
        format.html { redirect_to [:account, @site, :blog_lists], notice: I18n.t("blog_lists.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @blog_list] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/blog_lists/:id
  # PATCH/PUT /account/blog_lists/:id.json
  def update
    respond_to do |format|
      if @blog_list.update(blog_list_params)
        format.html { redirect_to [:account, @blog_list], notice: I18n.t("blog_lists.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @blog_list] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/blog_lists/:id
  # DELETE /account/blog_lists/:id.json
  def destroy
    @blog_list.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @site, :blog_lists], notice: I18n.t("blog_lists.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def blog_list_params
    strong_params = params.require(:blog_list).permit(
      :title,
      :description,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
