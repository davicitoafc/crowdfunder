class PledgesController < ApplicationController
  before_action :authenticate_user, :except => [:index, :show]

  def index
    @project = Project.find(params[:project_id])
    @pledges = @project.pledges.all
  end

  def new
    @project = Project.find(params[:project_id])
    @pledge = @project.pledges.build
  end

  def show
    @project = Project.find(params[:project_id])
    @pledge = Pledge.find(params[:id])
  end

  def create
    @project = Project.find(params[:project_id])
    @pledge = @project.pledges.build(pledges_params)
    @pledge.user = current_user

    if @pledge.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  private

  def pledges_params

    params.permit(:amount, :project_id)
  end

end
