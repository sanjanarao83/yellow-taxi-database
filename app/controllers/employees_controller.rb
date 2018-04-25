class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.all
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
    @employee = Employee.find[params[:id]]
  end

  def validate(employee,username,pass)
    if employee
      if employee["USER_NAME"] == username && employee["EMP_PASSWORD"] == pass
        redirect_to employees_contact_path
      else
        render :js => "alert('Invalid Username or Password')"
        return false
      end
    else
      render :js => "alert('Id does not exists')"
      return false
    end
    return true
  end

  #only check whether employee exists in employee table or not.
  def login
    @employees = Employee.new
  end

  def login_employee
    @employee_id = params[:empid]
    @username = params[:name]
    @pass = params[:password]
    conn = OCI8.new('sanjana', 'Srvrtvk83!', 'oracle.cise.ufl.edu/orcl')
    cursor = conn.parse("select * from employee where empid=#{@employee_id}")
    cursor.exec
    @employee = cursor.fetch_hash
    if validate(@employee,@username,@pass)
      render :js => "alert('Welcome!')"
    else
      render :js => "alert('Are you sure you are a USER yet?')"
    end
    conn.logoff
  end

  # GET /employees/NEW
  def new
    @employee = Employee.new
    session[:passed_variable] = params
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = params[:employee]
    @emp_type = "user"      
    puts "********************** Found the #{@emp_type} **********************"

    puts "********************** Found the #{@employee["empid"]} **********************"
    conn = OCI8.new('sanjana', 'Srvrtvk83!', 'oracle.cise.ufl.edu/orcl')
    cursor = conn.parse("insert into employee values ('#{@employee["empid"]}','#{@employee["first_name"]}','#{@employee["last_name"]}','#{@employee["user_name"]}','#{@employee["emp_password"]}','#{@employee["contact"]}','#{@employee["email"]}','user')")
    cursor.exec
    #@employee = cursor.fetch_hash
    if @employee
      redirect_to fares_path
      #format.html { redirect_to @employee, notice: 'You have successfully logged in.' }
      #format.json { render :show, status: :created, location: @employee }
    else
      flash.now[:danger] = 'Sorry we could not register you :('   
    end
    conn.logoff
  end

  # GET /employees/1/edit
  def edit
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def register_params
      params.require(:employee).permit(:first_name, :last_name, :email, :contact, :user_name, :emp_password)
    end

    def login_params
      params.require(:employee).permit(:user_name, :empid, :emp_password)
    end
end
