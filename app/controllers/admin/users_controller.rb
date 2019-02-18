class Admin::UsersController < Admin::AdminController

  skip_before_action :verify_authenticity_token, only: [:promote, :demote]

  def index
    @users = User.all.order(:name)
  end 

  def promote
    @user = User.find(params[:user_id])
    @user.admin = true
    @user.save

  end

  def demote
    @user = User.find(params[:user_id])
    @user.admin = false
    @user.save
  end

end