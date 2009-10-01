#  create_table "email_requests", :force => true do |t|
#    t.string   "code"
#    t.string   "action"
#    t.integer  "record_id"
#    t.integer  "status_id"
#    t.datetime "created_at"
#    t.datetime "updated_at"
#  end

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EmailRequest do
  fixtures :users

  before(:each) do
    @user = users(:valid_user)
  end

  it "should not be saved without action" do
    @er = EmailRequest.new(@user, "")
    @er.save.should be_false
  end

  it "should be created with initial status" do
    @er = EmailRequest.new(@user, "new_user")
    @er.status_id.should == Status::EmailRequest::PENDING
  end

  it "should be saved" do
    @er = EmailRequest.new(@user, "new_user")
    @er.save.should be_true
  end

  it "should be saved with status STEP_1" do
    @er = EmailRequest.new(@user, "new_user")
    @er.save.should be_true

    @er.status_id = Status::EmailRequest::STEP_1
    @er.save.should be_true
    EmailRequest.find(@er.id).should be_kind_of EmailRequest
  end

  it "should be moved to history if status is DONE" do
    @er = EmailRequest.new(@user, "new_user")
    @er.save.should be_true
    
    @er.status_id = Status::EmailRequest::DONE
    @er.save.should be_true

    EmailRequestHist.find_by_code(@er.code).should be_kind_of EmailRequestHist
  end

  it "should be deleted if status is DONE" do
    @er = EmailRequest.new(@user, "new_user")
    @er.save.should be_true

    @er.status_id = Status::EmailRequest::DONE
    @er.save.should be_true
    EmailRequest.all(:conditions => ["id = ?", @er.id]).should be_empty
  end

  it "should give error when tried to create without any parameter" do
    lambda { EmailRequest.new() }.should raise_error(ArgumentError)
  end
end
