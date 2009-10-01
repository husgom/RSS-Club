class WelcomeController < ApplicationController
  layout "welcome"

  def index

  end

  def add_company
    @company = Company.new()
    @user = User.new()
  end

  def create_company
    @company = Company.new(params[:company])

    begin
        @company.transaction do
          @user = User.new(params[:user])

          @company.save!

          @user.company = @company
          # ilk yaratılan kullanıcı o şirketin admini olur
          @user.company_admin = :true
          @user.save!

          @email_request = EmailRequest.new(@user, "new_user")
          @email_request.save!
          
          Notifications.deliver_new_user(@user, @email_request)
        end
    rescue
      flash[:warning] = "Bilgileri kayıt ederken bir sorun çıktı."
      #raise
      render(:action => :add_company)
    else
      flash[:info] = "Kaydınız alınmıştır. Az sonra e-posta adresinize bir mesaj gönderilecektir. Mesaj içerisindeki linki tıklayarak üyeliğinizi onaylayabilirsiniz. Ardından bilgileriniz incelenecek ve sistemi kullanmaya başlayabileceksiniz."
      redirect_to :action => :index
    end
  end

  def login
    session[:user_id] = nil
    session[:current_user] = nil
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user
        session[:user_id] = user.id
        session[:current_user] = user
        redirect_to(:controller => :login, :action => "index")
      else
        flash[:notice] = "Kullanıcı adı veya şifre yanlış."
      end
    end
  end

  def activate_user
    code = params[:key]
    email_request = EmailRequest.find_by_code_and_status_id(code, Status::EmailRequest::PENDING)
    if email_request
      begin
        email_request.transaction do
          email_request.status_id = Status::EmailRequest::DONE
          email_request.save!
          
          user = User.find(email_request.record_id)
          user.status_id = Status::User::VALIDATED
          user.save!

          # Sadece ilk kullanıcıların onaylanması sırasında firma durumu değiştirilir
          # onun dışında firma bilgisi ile işimiz yok
          if user.admin == :true
            company = user.company
            company.status_id = Status::Company::VALIDATED
            company.save!
          end
        end
      rescue
        flash[:warning] = "Bilgileri kayıt ederken bir sorun çıktı."
        #raise
      else
        flash[:notice] = "Üyeliğiniz onaylanmıştır."
        redirect_to :action => :index
      end
    else
        flash[:warning] = "Onaylamak işlemi, onay kodu bulunamadığı için yapılamadı."
    end
  end

  def i_forget_my_password

  end
  
  def send_change_password_request
    email = params[:email]
    name = params[:name]
    user = User.find_by_email_and_name(email, name)
    unless user
      flash[:warning] = "Kullanıcı bulunamadı."
      redirect_to :action => :index
      return false
    end

    begin
      @email_request = EmailRequest.new()
      @email_request.for_forget_password(user)
      @email_request.save!

      Notifications.deliver_forget_password(user, @email_request)
    rescue
      flash[:warning] = "E-posta gönderirken bir sorun oldu. Sistem yöneticisi ile iletişime geçiniz."
      raise
      redirect_to :action => :index
    else
      flash[:notice] = "E-posta adresinize şifre değiştirme talebinizi tamamlayabilmeniz için bir kod gönderilmiştir. Lüften e-postalarınızı kontrol ediniz."
      redirect_to :action => :index
    end    
  end

  def forget_password
    @code = params[:key]
    email_request = EmailRequest.find_by_code(@code)
    if email_request and email_request.status_id == Status::EmailRequest::PENDING
      begin
        email_request.transaction do
          email_request.status_id = Status::EmailRequest::STEP_1
          email_request.save!
        end
      rescue
        flash[:warning] = "Bilgileri kayıt ederken bir sorun çıktı."
        #raise
      else
        flash[:notice] = "Lütfen şifrenizi değiştiriniz."
        #redirect_to :action => :change_password, :id => code
      end
    else
        flash[:warning] = "Onaylamak işlemi, onay kodu bulunamadığı için yapılamadı."
        redirect_to :action => :index
    end
  end

  def change_password_with_key
    @code = params[:key]
    password = params[:new_password]
    password_confirm = params[:new_password_confirmation]

    if password != password_confirm
      flash[:warning] = "Şifreler birbiri ile aynı değil."
      render :action => :forget_password
      return false
    end

    email_request = EmailRequest.find_by_code(@code)
    if email_request and email_request.status_id == Status::EmailRequest::STEP_1
      begin
        email_request.transaction do
          email_request.status_id = Status::EmailRequest::DONE
          email_request.save!

          user = User.find(email_request.record_id)
          user.password= password
          user.save!
        end
      rescue
        flash[:warning] = "Bilgileri kayıt ederken bir sorun çıktı."
        raise
        render :action => :forget_password
      else
        flash[:notice] = "Lütfen şifrenizi değiştiriniz."
        redirect_to :action => :index
      end
    else
        flash[:warning] = "Onaylamak işlemi, onay kodu bulunamadığı için yapılamadı."
        redirect_to :action => :index
    end
  end
end
