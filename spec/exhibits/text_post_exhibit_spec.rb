require "minitest/autorun"
require "ostruct"
require_relative "../spec_helper_lite"
require_relative "../../app/exhibits/exhibit.rb"
require_relative "../../app/exhibits/text_post_exhibit"

describe TextPostExhibit do
  let(:post) { OpenStruct.new(
    title: "TITLE",
    body: "BODY",
    pubdate: "PUBDATE")
  }
  let(:context) { stub! }
  let(:tpexhibit) { TextPostExhibit.new(post, context) }

  it "delegates method calls to the post" do
    tpexhibit.title.must_equal("TITLE")
    tpexhibit.body.must_equal("BODY")
    tpexhibit.pubdate.must_equal("PUBDATE")
  end

  it "renders itself with the appropriate partial" do
    mock(context).render(
      partial: "/posts/text_body", locals: { post: tpexhibit }) {
        "THE_HTML"
      }
      tpexhibit.render_body.must_equal("THE_HTML")
  end
end
