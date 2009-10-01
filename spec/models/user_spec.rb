require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  fixtures :users
  
  before(:each) do
    @user = users(:valid_user)
  end

  it "should not be saved without name" do
    user = @user
    user.name = ""
    user.save.should_not be_true
  end

  it "should not be saved without contact_name" do
    user = @user
    user.contact_name = ""
    user.save.should_not be_true
  end

  it "should not be saved without email" do
    user = @user
    user.email = ""
    user.save.should_not be_true
  end

  it "should not be saved without company" do
    user = @user
    user.company = nil
    user.save.should_not be_true
  end

  it "should not be saved without user_type" do
    user = @user
    user.user_type = nil
    user.save.should_not be_true
  end

  it "should be saved" do
    user = @user
    user.save.should be_true
    user.should have(0).errors
  end

  it "should have initial status_id of VALPENDING" do
    user = User.new
    user.status_id.should == Status::User::VALPENDING
  end
end
