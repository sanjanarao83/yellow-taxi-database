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

  #only check whether employee exists in employee table or not.
  def login
    puts "*********************** LOGIN in EMPLOYEE ***************************"
    @employees = Employee.new
  end

  def login_employee
        puts "********************** LOGIN_PARAMS "+" **********************"

    puts "********************* LOGIN_EMPLOYEE in EMPLOYEE ***********************"
    @employee_id = params[:empid]
    @username = params[:name]
    @pass = params[:password]
    conn = OCI8.new('sanjana', 'Srvrtvk83!', 'oracle.cise.ufl.edu/orcl')
    cursor = conn.parse("select * from employee where empid="+@employee_id)

  #  puts "********************** Found the "+login_params+" **********************"
    cursor.exec

    @employee = cursor.fetch_hash
     # if @employee == 'NIL'
     #   render :js => "alert('Invalid Username or Password')"
     # end
    # puts @employee
    # puts "NAME YAHA AANA CHAHIE"
    # puts @employee["EMPID"]
    # puts @employee_id
    # puts @employee["USER_NAME"]
    # puts @username
    # puts @employee["EMP_PASSWORD"]
    # puts @pass

if @employee

    if @employee["USER_NAME"] == @username && @employee["EMP_PASSWORD"] == @pass
   # puts "********************** Found the "+@employee.first_name+" **********************"
      redirect_to employees_contact_path
      #format.html { redirect_to @employee, notice: 'You have successfully logged in.' }
     # format.json { render :show, status: :created, location: @employee }
    else
      render :js => "alert('Invalid Username or Password')"
      #flash.now[:danger] = 'Invalid email/password combination or you are not a user yet.'
    end

  else
       render :js => "alert('Id does not exists')"
  end

    conn.logoff
  end



  # GET /employees/NEW
  def new
    puts "********************* NEW in EMPLOYEE ************************"
    @employee = Employee.new
  end

  # POST /employees
  # POST /employees.json
  def create
    puts "********************* CREATE in EMPLOYEE ************************"
    @employee = Employee.new(register_params)
    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
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
