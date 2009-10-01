#START:authorize
#START:layout
class LoginController < ApplicationController
#END:layout

  #START:filter
  before_filter :authorize, :except => [:login,  :welcome, :add_company, :create_company]
  before_filter :authorize_admin, :only => :add_user
  #END:filter
  # . . 
#END:authorize
#START:layout

#END:layout

  #START:index
  def index
    @demands = Demand.find(:all, :conditions => ["status_id <> ?", Status::Demand::NEW], :order => "created_at desc", :limit => 5)
    #current_user = User.find(session[:user_id])
    @my_demands = @current_user.demands.find(:all, :order => "created_at desc", :limit => 5)
    @offers = Offer.find(:all, :conditions => ["demand_id in (?)", @my_demands.map{|d| d.id}.join(",")], :limit => "10", :order => "created_at desc")
    @my_offers = @current_user.offers.find(:all, :order => "created_at desc", :limit => 5)
  end
  #END:index

  #START:add_user
  def add_user
    @user = User.new(params[:user])
    if request.post? and @user.save
      flash.now[:notice] = "User #{@user.name} created"
      @user = User.new
    end
  end

  # . . .
  #END:add_user

  #START:delete_user
  def delete_user
    if request.post?
      user = User.find(params[:id])
      begin
        user.destroy
        flash[:notice] = "User #{user.name} deleted"
      rescue Exception => e
        flash[:notice] = e.message
      end
    end
    redirect_to(:action => :list_users)
  end
  #END:delete_user

  #START:list_users
  def list_users
    @all_users = User.find(:all)
  end
  #END:list_users
  
  #START:logout
  def logout
    session[:user_id] = nil
    session[:current_user] = nil
    flash[:notice] = "Sistemden güvenle çıktınız."
    redirect_to(:controller => "welcome")
  end
  #END:logout

end
