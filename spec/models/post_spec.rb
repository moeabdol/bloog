require "minitest/autorun"
require "date"
require "active_model"
require_relative "../spec_helper_lite"
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

  it "is not valid with a blank title" do
    [nil, "", " "].each do |bad_title|
      post.title = bad_title
      refute post.valid?
    end
  end

  it "is valid with a non-blank title" do
    post.title = "x"
    assert post.valid?
  end

  describe "#publish" do
    let(:post) { Post.new(title: "hello", body: "world") }
    let(:blog) { MiniTest::Mock.new }
    before { post.blog = blog }
    after { blog.verify }

    it "adds the post to the blog" do
      blog.expect :add_entry, nil, [post]
      post.publish
    end

    describe "given an invalid post" do
      before { post.title = nil }

      it "wont add the post to the blog" do
        dont_allow(blog).add_entry
        post.publish
      end

      it "returns false" do
        refute post.publish
      end
    end
  end

  describe "#pubdate" do
    describe "before publishing" do
      it "is blank" do
        post.pubdate.must_be_nil
      end
    end

    describe "after publishing" do
      let(:post) { Post.new(title: "hello", body: "world") }
      let(:clock) { stub! }
      let(:now) { DateTime.parse("2011-09-11T02:56") }

      before do
        stub(clock).now() { now }
        post.blog = stub!
        post.publish(clock)
      end

      it "is a datetime" do
        post.pubdate.class.must_equal(DateTime)
      end

      it "is the current time" do
        post.pubdate.must_equal(now)
      end
    end
  end

  describe "#picture?" do
    it "is true when the post has a picture url" do
      post.image_url = "http://example.org/foo.png"
      assert(post.picture?)
    end

    it "is false when the post has no picture url" do
      post.image_url = ""
      refute(post.picture?)
    end
  end
end
