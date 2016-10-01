class VisitsController < ApplicationController
  before_action :set_visit, only: [:show]
  layout "employee", only: [:index]

  skip_before_action :authenticate_user, only: [:index]

  def new
    @visit = client.visits.new
    @calendar = Day.build 2
  end

  def create
    @visit = client.visits.new(visit_params)
    if @visit.save
      redirect_to visit_path(@visit),
        notice: 'Visita creada'
    else
      @calendar = Day.build 2
      render :new
    end
  end

  def index
    @employee = Employee.find params[:employee_id]
    @visits = @employee.visits.where(:turns => { at: Date.today })
  end

  private

  def set_visit
    @visit = Visit.find(params[:id])
  end

  def visit_params
    params.require(:visit).permit(:description, :duration, :client,
                                  turn_attributes)
  end

  def turn_attributes
    if params['visit']['turn_id'].present?
      :turn_id
    else
      { turn_attributes: [:at, :employee_id] }
    end
  end

  def client
    @client ||= Client.find_by! dni: params[:client_dni]
  end
end
