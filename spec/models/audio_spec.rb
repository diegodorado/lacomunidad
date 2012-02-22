require File.dirname(__FILE__) + '/../spec_helper'

describe Audio do
  it "should be valid" do
    Audio.new.should be_valid
  end
end
