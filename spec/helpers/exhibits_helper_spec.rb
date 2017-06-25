require "minitest/autorun"
require_relative "../spec_helper_lite"
require_relative "../../app/helpers/exhibits_helper"

stub_class "PicturePostExhibit"
stub_class "TextPostExhibit"
stub_class "Post"

describe ExhibitsHelper do
  let(:exhibits_helper) { Object.new }
  let(:context) { stub! }
  before { exhibits_helper.extend ExhibitsHelper }

  it "decorates picture post with PicturePostExhibit" do
    post = Post.new
    stub(post).picture? { true }
    exhibits_helper.exhibit(post, context).class.must_be_same_as(
      PicturePostExhibit)
  end

  it "decorates text post with TextPostExhibit" do
    post = Post.new
    stub(post).picture? { false }
    exhibits_helper.exhibit(post, context).class.must_be_same_as(
      TextPostExhibit)
  end

  it "leaves objects it doesn't know about alone" do
    model = Object.new
    exhibits_helper.exhibit(model, context).must_be_same_as(model)
  end
end
