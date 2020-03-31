class EmployeesController < ApplicationController
  
  before_action :set_employee, only: [:update, :edit, :show]
  
  def index
      @active_managers = Employee.managers.active
      @active_employees = Employee.active
      @inactive_employees = Employee.inactive
  end
    
  def show
      #@employee = Employee.find(params[:id])
      @current_assignment = Assignment.for_employee(@employee.id).current
	  @previous_assignments = Assignment.for_employee(@employee.id).past.chronological
  end
      
  def new
      @employee = Employee.new
  end
  
  def create
      @employee = Employee.new(employee_params)
    if @employee.save
      # if saved to database
      flash[:notice] = "Successfully added #{@employee.proper_name} as an employee."
      redirect_to employee_path(@employee) # go to show employee page
    else
      # return to the 'new' form
      render action: 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @employee.update_attributes(employee_params)
      flash[:notice] = "Updated #{@employee.proper_name}'s information."
      redirect_to @employee
    else
      render action: 'edit'
    end
  end
  
#   def destroy
#     @employee.destroy
#     flash[:notice] = "Successfully removed #{@employee.proper_name} from the A&M Creamery system."
#     redirect_to employees_url
#   end
  
  
   private
    def set_employee
      @employee = Employee.find(params[:id])
    end
    
    def employee_params
      params.require(:employee).permit(:first_name, :last_name, :ssn, :phone, :date_of_birth, :role, :active) unless params.nil?
    end
    
end