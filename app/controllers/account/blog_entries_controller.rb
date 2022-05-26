class Account::BlogEntriesController < Account::ApplicationController
  account_load_and_authorize_resource :blog_entry, through: :site, through_association: :blog_entries

  # GET /account/sites/:site_id/blog_entries
  # GET /account/sites/:site_id/blog_entries.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @site]
  end

  # GET /account/blog_entries/:id
  # GET /account/blog_entries/:id.json
  def show
  end

  # GET /account/sites/:site_id/blog_entries/new
  def new
  end

  # GET /account/blog_entries/:id/edit
  def edit
  end

  # POST /account/sites/:site_id/blog_entries
  # POST /account/sites/:site_id/blog_entries.json
  def create
    respond_to do |format|
      if @blog_entry.save
        format.html { redirect_to [:account, @site, :blog_entries], notice: I18n.t("blog_entries.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @blog_entry] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/blog_entries/:id
  # PATCH/PUT /account/blog_entries/:id.json
  def update
    respond_to do |format|
      if @blog_entry.update(blog_entry_params)
        format.html { redirect_to [:account, @blog_entry], notice: I18n.t("blog_entries.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @blog_entry] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/blog_entries/:id
  # DELETE /account/blog_entries/:id.json
  def destroy
    @blog_entry.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @site, :blog_entries], notice: I18n.t("blog_entries.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def blog_entry_params
    strong_params = params.require(:blog_entry).permit(
      :summary,      
      :title,
      :pinned_value,
      :publish_at,
      :seo_title,
      :seo_description,
      :hero_image,
      :image,
      :content,
      blog_list_ids: [],
      blog_lists: [],
      
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    assign_date_and_time(strong_params, :publish_at)
    # 🚅 super scaffolding will insert processing for new fields above this line.
    assign_select_options(strong_params, :blog_list_ids)

    
    
    strong_params
  end
end
