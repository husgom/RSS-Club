class UsersController < ApplicationController
  before_filter :authorize

  def index
    @users = @current_user.company.users.all
  end

  def show
    @user = @current_user.company.users.find(params[:id])
    @company = @user.company
  end

  def edit
    @user = @current_user.company.users.find(params[:id])
    @company = @user.company
  end

  def update
    @user = @current_user.company.users.find(params[:id])
    @company = @user.company

    @user.contact_name = params[:user][:contact_name]

    if @user.save
      flash[:notice] = 'Bilgi başarıyla güncellendi.'
      redirect_to :action => :show, :id => @user
    else
      render :action => :edit
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])


    begin
        @user.transaction do
          @user.status_id = Status::User::VALPENDING

          @user.company = @current_user.company
          @user.company_name = @current_user.company.name
          @user.admin = :false
          @user.user_type_id = @current_user.user_type_id
          @user.save!

          @email_request = EmailRequest.new()
          @email_request.for_new_user(@user)
          @email_request.save!

          Notifications.deliver_new_user(@user, @email_request)
        end
    rescue
      flash[:warning] = "Bilgileri kayıt ederken bir sorun çıktı."
      raise
      render(:action => :new)
    else
      flash[:info] = "Kaydınız alınmıştır. Az sonra e-posta adresinize bir mesaj gönderilecektir. Mesaj içerisindeki linki tıklayarak üyeliğinizi onaylayabilirsiniz. Ardından bilgileriniz incelenecek ve sistemi kullanmaya başlayabileceksiniz."
      redirect_to :action => :show, :id => @user
    end
  end

  def edit_company
  end

  def change_password
    old_password = params[:old_password] || ""
    new_password = params[:new_password] || ""
    new_password_confirmation = params[:new_password_confirmation] || ""
    
    @user = @current_user.company.users.find(params[:id])
    @company = @user.company

    if (old_password.size >= 0) or (@user.password_valid?(old_password) == :false)
        flash[:warning] = "Mevcut şifreniz yanlış veya boş."
        render :action => :show, :id => @user
        return false
     else
      if new_password.size == 0  or new_password != new_password_confirmation
        flash[:warning] = "Yeni şifreler bir birleri ile aynı olmalıdır."
        render :action => :show, :id => @user
        return false
      else
        @user.password= new_password
        if @user.save
          flash[:notice] = "Şifreniz değiştirilmiştir."
          redirect_to :action => :show, :id => @user
        else
          flash[:warning] = "Şifre değiştirilemedi."
          render :action => :show, :id => @user
        end
      end
    end
  end

end
