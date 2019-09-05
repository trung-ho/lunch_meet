class UsersController < ApplicationController
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  def show
    @user = User.find user_id
  end

  def dashboard
  end

  def select_preferences
    @user = current_user
    @user.preference_ids = @user.preferences.pluck(:id)
  end

  def set_preferences
    remove_preference_ids = []
    add_preference_ids = []

    current_preferences = current_user.preferences.pluck(:id)
    new_preferences = preference_params

    remove_preference_ids = current_preferences - new_preferences
    add_preference_ids = new_preferences - current_preferences

    remove_preferences = current_user.user_categories.where(category_id: remove_preference_ids)
    remove_preferences.destroy_all if remove_preferences.any?

    add_preference_ids.each do |id|
      current_user.user_categories.create category_id: id
    end

    redirect_to current_user, flash: { success: 'Your preferences has been updated successfully'}
  end

  private

  def user_id
    params['id']
  end

  def preference_params
    params[:user][:preference_ids].reject { |c| c.empty? }
  end
end