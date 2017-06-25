require_relative "../models/post"

class LinkExhibit < Exhibit
  def render_body
    @context.render(partial: "/posts/link_body", locals: { post: self })
  end

  def applicable_to?(object)
    object.is_a?(Post)
  end
end
