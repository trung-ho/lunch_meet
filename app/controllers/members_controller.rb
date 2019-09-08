class MembersController < ApplicationController
  before_action :authenticate_user!

  def index
    @group = Group.find group_id
    @members = @group.members
  end

  def add
    @group = Group.includes(:members).find group_id
    @q = User.page(params[:page]).ransack(params[:q])

    if params[:q].present?
      @users = @q.result(distinct: true).order(created_at: :desc)
    else
      @users = []
    end
    @group_member = @group.group_members.new
  end

  def create
    @group_member = GroupMember.new group_member_params
    if @group_member.save
      # flash[:success] = 'Member added succesfully.'
      redirect_to @group_member.group, flash: { success: 'Member added succesfully.'}
    else
      render :add
    end
  end

  def destroy
    @group = current_user.groups.find group_id
    if @group
      @member = @group.group_members.where(user_id: member_id).first
      if @member.present?
        if @member.destroy
          flash[:success] = 'Member has been removed successfully'
          redirect_to group_members_path @group
          return
        end
      end
    end
    flash[:error] = 'omething went wrong!'
    redirect_to group_members_path @group, flash: { error: 'Something went wrong!'}
  end

  private

  def group_id
    params[:group_id]
  end

  def member_id
    params[:id]
  end

  def group_member_params
    params.require(:group_member).permit(:group_id, :user_id)
  end
end