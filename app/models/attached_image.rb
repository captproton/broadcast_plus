# image:     "#{url_for(@site.general_info.meta_image).to_s " "}"
class AttachedImage
    attr_accessor :model, :image_name

    def initialize(model=@site.setting_general_infos.first, 
        image_name="meta_image")
      @model        = model
      @image_name   = image_name.to_s
    end

    def url
        # avatar = users(:david).avatar
        if self._image_attached?
            result =  Rails.application.routes.url_helpers.rails_blob_path(@model.public_send(@image_name), only_path: true)
        else
            result = MissingAttachedImage.new.url
        end
        url = result
    end

    def _image_attached?
        @model.public_send(@image_name).attached?
    end
end
