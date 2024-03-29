class UsersController < ApplicationController
  
  # before_filter arranges for a particular method to be called before the given actions
  # By default to every action in controller
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  
  def new
    @user = User.new
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def create 
    @user = User.new(params[:user])
    if @user.save
      #Handle a successful save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      # Successful edit
      flash[:success] = "Profile updated"
      sign_in @user                           # Sign in bc of a successful update
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  
  def destroy 
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed"
    redirect_to users_url
  end
  
  
  private  
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
  
  def admin_user
    redirect_to root_path unless current_user.admin?
  end
  
end
