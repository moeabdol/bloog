require_relative "../exhibits/exhibit"
require_relative "../exhibits/picture_post_exhibit"
require_relative "../exhibits/text_post_exhibit"

module ExhibitsHelper
  def exhibit(model, context)
  #   case model.class.name
  #   when "Post"
  #     if model.picture?
  #       PicturePostExhibit.new(model, context)
  #     else
  #       TextPostExhibit.new(model, context)
  #     end
  #   else
  #     model
  #   end

    Exhibit.exhibit(model, context)
  end
end
