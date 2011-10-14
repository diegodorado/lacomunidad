require 'spec_helper'

describe StaticController do

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET 'docs'" do
    it "should be successful" do
      get 'docs'
      response.should be_success
    end
  end

  describe "GET 'news'" do
    it "should be successful" do
      get 'news'
      response.should be_success
    end
  end

  describe "GET 'participate'" do
    it "should be successful" do
      get 'participate'
      response.should be_success
    end
  end

  describe "GET 'what'" do
    it "should be successful" do
      get 'what'
      response.should be_success
    end
  end

end
