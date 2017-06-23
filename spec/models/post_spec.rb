require "minitest/autorun"
require_relative "../../app/models/post"
require_relative "../../app/models/blog"

describe Post do
  let(:post) { Post.new }

  it "starts with blank attributes" do
    post.title.must_be_nil
    post.body.must_be_nil
  end

  it "supports reading and writing a title" do
    post.title = "foo"
    post.title.must_equal "foo"
  end

  it "supports reading and writing a post body" do
    post.body = "foo"
    post.body.must_equal "foo"
  end

  it "supports reading and writing a blog reference" do
    blog = Blog.new
    post.blog = blog
    post.blog.must_equal blog
  end

  it "supports setting attributes in the initializer" do
    post = Post.new(title: "mytitle", body: "mybody")
    post.title.must_equal("mytitle")
    post.body.must_equal("mybody")
  end

  describe "#publish" do
    let(:blog) { MiniTest::Mock.new }
    before { post.blog = blog }
    after { blog.verify }

    it "adds the post to the blog" do
      blog.expect :add_entry, nil, [post]
      post.publish
    end
  end
end
