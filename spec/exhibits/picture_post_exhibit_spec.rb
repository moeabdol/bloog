require "minitest/autorun"
require "ostruct"
require_relative "../spec_helper_lite"
require_relative "../../app/exhibits/picture_post_exhibit.rb"

describe PicturePostExhibit do
  let(:post) { OpenStruct.new(
    title: "TITLE",
    body: "BODY",
    pubdate: "PUBDATE")
  }
  let(:context) { stub! }
  let(:ppexhibit) { PicturePostExhibit.new(post, context) }

  it "delegates method calls to the post" do
    ppexhibit.title.must_equal("TITLE")
    ppexhibit.body.must_equal("BODY")
    ppexhibit.pubdate.must_equal("PUBDATE")
  end

  it "renders itself with the appropriate partial" do
    mock(context).render(
      partial: "/posts/picture_body", locals: { post: ppexhibit }) {
        "THE_HTML"
      }
      ppexhibit.render_body.must_equal("THE_HTML")
  end
end
