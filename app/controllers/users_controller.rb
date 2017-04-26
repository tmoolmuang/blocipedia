class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    @users = User.all
    authorize User
  end
  
  def downgrade
    @user = User.find(params[:id])
    @user.role = 'standard'

    authorize User
    
    if @user.save
      flash[:notice] = "Your premium membership has been downgraded to standard level. Your private wikis are now public."
      redirect_to root_path
    else
      flash[:error] = "There was an error downgrading your membership. Please try again."
      redirect_to :back
    end
    
    @user_wikis = @user.wikis.where(private: true)

    @user_wikis.each do |wiki|
      wiki.update_attributes(private: false)
    end
    
  end
  


  # will be delelted?
  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def secure_params
    params.require(:user).permit(:role)
  end

end
