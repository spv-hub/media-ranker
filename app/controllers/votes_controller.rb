class VotesController < ApplicationController
  def create
    @user = User.find_by(id: session[:user_id])
    @work = Work.find(params[:work_id])

    @vote = Vote.new
    @vote.work_id = @work.id

    if @user.nil?
      flash[:error] = "Unable to vote, please log in first."
      redirect_to root_path
      return
    end

    @vote.user_id = @user.id
    @vote.date = Date.today

    if @vote.save
      flash[:session] = "Success"
      redirect_to work_path(@work) #work_path(@work)
    else
      flash[:error] = "Error, not able to upvote"
      redirect_to root_path
    end
  end
end
