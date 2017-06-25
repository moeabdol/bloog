require_relative "../models/post"

class TextPostExhibit < Exhibit
  def render_body
    @context.render(partial: "/posts/text_body", locals: { post: self })
  end

  def self.applicable_to?(object)
    object.is_a?(Post) && !object.picture?
  end
end
