require 'spec_helper'

describe "blog_posts/new" do
  before(:each) do
    assign(:blog_post, stub_model(BlogPost,
      :title => "MyString",
      :embed => "MyString",
      :body => "MyString"
    ).as_new_record)
  end

  it "renders new blog_post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => blog_posts_path, :method => "post" do
      assert_select "input#blog_post_title", :name => "blog_post[title]"
      assert_select "input#blog_post_embed", :name => "blog_post[embed]"
      assert_select "input#blog_post_body", :name => "blog_post[body]"
    end
  end
end
