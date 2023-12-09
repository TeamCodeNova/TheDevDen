class AccountsController < ApplicationController
  before_action :require_user
  helper_method :current_user

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user


    if user_params[:password].present? || user_params[:password_confirmation].present?
      # If password fields are present, update password
      if @user.update(user_params)
        flash[:success] = 'Password updated successfully.'
      else
        render :edit
        return
      end
    else
      # If no password fields, update other attributes
      if @user.update(user_params.except(:password, :password_confirmation))
        flash[:success] = 'Profile updated successfully.'
      else
        render :edit
        return
      end
    end


    redirect_to account_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :address, :province_id, :password, :password_confirmation, :postal_code)
          .reject { |_, v| v.blank? }
  end

end

