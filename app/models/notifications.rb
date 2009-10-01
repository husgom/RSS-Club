class Notifications < ActionMailer::Base
  

  def demand_closed(demand = Demand.find(:last), sent_at = Time.now)
    subject    'İhale Kapandı: ' + demand.name
    recipients  demand.user.email_with_name
    from       'info@husey.in'
    sent_on    sent_at
    # content_type 'text/html'
    
    body       :greeting => 'Hi,'
    attachment  "application/png" do |a|
                a.body = File.read(RAILS_ROOT + "/public/images/rails.png")
                a.filename = "rails.png"
    end
  end


  def new_user (user, email_request, sent_at = Time.now)
    subject 'OSAP İhale Sistemi: Üyelik Onayı'
    recipients user.email_with_name
    from  FROM
    sent_on sent_at
    content_type 'text/html'

    body :user_name => user.name, :request_code => email_request.code
  end

  def forget_password (user, email_request, sent_at = Time.now)
    subject 'OSAP İhale Sistemi: Şifre Hatırlatma'
    recipients user.email_with_name
    from  FROM
    sent_on sent_at
    content_type 'text/html'

    body :user_name => user.name, :request_code => email_request.code
  end

end
