require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EmailRequestHist do
  before(:each) do
    @valid_attributes = {
      :code => "value for code",
      :action => "value for action",
      :status_id => 1,
      :record_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    EmailRequestHist.create!(@valid_attributes)
  end
end
