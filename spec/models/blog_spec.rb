require "minitest/autorun"
require_relative "../../app/models/blog.rb"
require "ostruct"
require "date"
require "rr"

describe Blog do
  let(:blog) { Blog.new }
  let(:entries) { [] }

  it "has no entries" do
    blog.entries.must_be_empty
  end

  describe "#new_post" do
    let(:new_post) { OpenStruct.new }
    before { blog.post_source = -> { new_post } }

    it "returns a new post" do
      blog.new_post.must_equal new_post
    end

    it "sets the post's blog reference to itself" do
      blog.new_post.blog.must_equal(blog)
    end

    it "accepts an attribute hash on behalf of the post maker" do
      post_source = MiniTest::Mock.new
      post_source.expect(:call, new_post, [{ x: 42, y: "z" }])
      blog.post_source = post_source
      blog.new_post(x: 42, y: "z")
      post_source.verify
    end
  end

  describe "#add_entry" do
    it "adds the entry to the blog" do
      entry = stub!
      blog.add_entry(entry)
      blog.entries.must_include(entry)
    end
  end

  describe "#entries" do
    def stub_entry_with_date(date)
      OpenStruct.new(pubdate: DateTime.parse(date))
    end

    it "is stored in reverse-chronological order" do
      oldest = stub_entry_with_date("2011-09-09")
      newest = stub_entry_with_date("2011-09-11")
      middle = stub_entry_with_date("2011-09-10")
      blog.add_entry(oldest)
      blog.add_entry(newest)
      blog.add_entry(middle)
      blog.entries.must_equal([newest, middle, oldest])
    end

    it "is limited to 10 items" do
      10.times do |i|
        blog.add_entry(stub_entry_with_date("2011-09-#{i + 1}"))
      end
      oldest = stub_entry_with_date("2011-08-30")
      blog.add_entry(oldest)
      blog.entries.size.must_equal(10)
      blog.entries.wont_include(oldest)
    end
  end
end
