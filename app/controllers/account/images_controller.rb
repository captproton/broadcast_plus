class Account::ImagesController < Account::ApplicationController
  account_load_and_authorize_resource :image, through: :site, through_association: :images

  # GET /account/sites/:site_id/images
  # GET /account/sites/:site_id/images.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @site]
  end

  # GET /account/images/:id
  # GET /account/images/:id.json
  def show
  end

  # GET /account/sites/:site_id/images/new
  def new
  end

  # GET /account/images/:id/edit
  def edit
  end

  # POST /account/sites/:site_id/images
  # POST /account/sites/:site_id/images.json
  def create
    respond_to do |format|
      if @image.save
        format.html { redirect_to [:account, @site, :images], notice: I18n.t("images.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @image] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/images/:id
  # PATCH/PUT /account/images/:id.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to [:account, @image], notice: I18n.t("images.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @image] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/images/:id
  # DELETE /account/images/:id.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @site, :images], notice: I18n.t("images.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def image_params
    strong_params = params.require(:image).permit(
      :title,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
