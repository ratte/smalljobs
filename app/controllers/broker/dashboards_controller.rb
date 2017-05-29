class Broker::DashboardsController < ApplicationController

  before_filter :authenticate_broker!

  load_and_authorize_resource :job, through: :current_region
  load_and_authorize_resource :provider, through: :current_region
  load_and_authorize_resource :seeker, through: :current_region

  def show
    @jobs = current_broker.jobs.includes(:provider, :organization).order(:last_change_of_state)
    allocations = Allocation.where(job: @jobs).includes(:seeker)
    @allocations = []
    allocations.each do |allocation|
      @allocations[allocation.job_id] = [] if @allocations[allocation.job_id].nil?
      @allocations[allocation.job_id][Allocation.states[allocation.state]] = [] if @allocations[allocation.job_id][Allocation.states[allocation.state]].nil?
      @allocations[allocation.job_id][Allocation.states[allocation.state]].push(allocation)
    end

    @providers = current_broker.providers.includes(:place, :jobs, :organization).order(:updated_at)
    @seekers = current_broker.seekers.includes(:place, :organization).order(:updated_at)
    @assignments = current_broker.assignments.includes(:seeker, :provider).order(:created_at)
    @todos = Todo.where(seeker: @seekers).or(Todo.where(provider: @providers)).or(Todo.where(job: @jobs)).or(Todo.where(allocation: allocations)).order(:created_at)
  end

  def save_settings
    current_broker.selected_organization_id = params[:selected_organization_id]
    current_broker.filter = params[:filter]
    current_broker.save!
    render json: {message: 'ok', broker: current_broker.selected_organization_id}
  end

  protected

  def current_user
    current_broker
  end
end
