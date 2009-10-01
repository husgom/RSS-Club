require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Company do
  fixtures :companies

  before(:each) do
    @company = companies(:valid_company)
  end

  it "should not be saved without name" do
    company = @company
    company.name = ""
    company.save.should_not be_true
  end

  it "should have initial status_id of VALPENDING" do
    company = Company.new
    company.status_id.should == Status::Company::VALPENDING
  end

  it "should be saved" do
    company = @company
    company.save.should be_true
    company.should have(0).errors
  end
end
