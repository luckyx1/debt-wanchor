# frozen_string_literal: true

# UsersController hanldes user-related actions such as creation, deletion, and modications.
class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = 'User destroyed'
    else
      flash[:error] = 'User unable to destory'
    end
    redirect_to users_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'User created'
      redirect_to @user
    else
      # This line overrides the default rendering behavior, which
      # would have been to render the "create" view.
      flash[:error] = 'User invalid'
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'User modified'
      redirect_to @user
    else
      # This line overrides the default rendering behavior, which
      # would have been to render the "create" view.
      flash[:error] = 'User invalid'
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :debt)
  end
end
