#  create_table "email_requests", :force => true do |t|
#    t.string   "code"
#    t.string   "action"
#    t.integer  "record_id"
#    t.integer  "status_id"
#    t.datetime "created_at"
#    t.datetime "updated_at"
#  end

require 'digest/sha1'

class EmailRequest < ActiveRecord::Base
  after_save :move_to_history
  validates_presence_of :action, :code, :record_id

  def initialize(record, action, *params)
    super(*params)
    self.code = self.get_code
    self.record_id = record.id
    self.action = action
    self.status_id = Status::EmailRequest::PENDING
  end

  def get_code
    Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
  end

  def EmailRequest.process(code)
    email_request = EmailRequest.find_by_code_and_status_id(code, Status::EmailRequest::PENDING)
    if email_request
      
    end    
  end

  protected

  def move_to_history
    if self.status_id == Status::EmailRequest::DONE
      EmailRequestHist.create(self.attributes)
      self.destroy
    end
  end

end
