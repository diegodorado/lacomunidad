require 'spec_helper'

describe "blog_posts/index" do
  before(:each) do
    assign(:blog_posts, [
      stub_model(BlogPost,
        :title => "Title",
        :embed => "Embed",
        :body => "Body"
      ),
      stub_model(BlogPost,
        :title => "Title",
        :embed => "Embed",
        :body => "Body"
      )
    ])
  end

  it "renders a list of blog_posts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Embed".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Body".to_s, :count => 2
  end
end
