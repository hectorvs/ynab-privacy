class UsersController < ApplicationController

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      # TODO: do something to verify privacy key
      redirect_to request.base_url, notice: 'Saved Privacy Access Key!'
    else
      redirect_to request.base_url, notice: 'Error saving Privacy Key'
    end
  end

  def edit; end

  private

  def user_params
    params.require(:user).permit(:privacy_key)
  end
end
