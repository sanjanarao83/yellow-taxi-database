class FaresController < ApplicationController
  before_action :set_fare, only: [:show, :edit, :update, :destroy]

  # GET /fares
  # GET /fares.json
  def index
    @fareval = params[:month]
    if @fareval then
      puts "Value of selected month is " + @fareval
      conn = OCI8.new('sanjana', 'Srvrtvk83!', 'oracle.cise.ufl.edu/orcl')
      #@fares = []
      #query = "SELECT * FROM TRIP_DATA WHERE ROWNUM < 10"
      query = "SELECT TRIP_DISTANCE as \"Trip Distance\", FARE_DATA.TOLLS_AMOUNT as \"Total tolls\" FROM TRIP_DATA, FARE_DATA WHERE TRIP_DATA.RECORDID = FARE_DATA.RECORDID AND TRIP_DATA.RECORDID = (SELECT RECORDID FROM FARE_DATA WHERE TOLLS_AMOUNT = (SELECT MAX(TOLLS_AMOUNT) FROM FARE_DATA))"
      cursor = conn.parse(query)
      cursor.exec
      #while r = cursor.fetch_hash
    #    @fares << r
    #  end
    #  puts @fares
      conn.logoff
      format.html { render action: "index" }
    else
      conn = OCI8.new('sanjana', 'Srvrtvk83!', 'oracle.cise.ufl.edu/orcl')
      @fares = []
      query = "SELECT * FROM TRIP_DATA WHERE ROWNUM < 10"
      #query = "SELECT TRIP_DISTANCE as \"Trip Distance\", FARE_DATA.TOLLS_AMOUNT as \"Total tolls\" FROM TRIP_DATA, FARE_DATA WHERE TRIP_DATA.RECORDID = FARE_DATA.RECORDID AND TRIP_DATA.RECORDID = (SELECT RECORDID FROM FARE_DATA WHERE TOLLS_AMOUNT = (SELECT MAX(TOLLS_AMOUNT) FROM FARE_DATA))"
      #query = "SELECT TO_CHAR(PICKUP_DATETIME, 'mm') AS \"Month\", COUNT(RECORDID) AS \"Passenger Count\" FROM TRIP_DATA WHERE TO_CHAR(PICKUP_DATETIME, 'YYYY')=2015 GROUP BY TO_CHAR(PICKUP_DATETIME, 'mm') ORDER BY TO_CHAR(PICKUP_DATETIME, 'mm') DESC"
      #query = "SELECT * FROM TRIP_DATA WHERE ROWNUM < 50"
      cursor = conn.parse(query)
      cursor.exec
      while r = cursor.fetch_hash
        @fares << r
      end
      puts @fares
      conn.logoff
    end
  end

  def onMonthSelect
  end

  # GET /fares/new
  def new

  end

  # GET /fares/1/edit
  def edit
  end

  # POST /fares
  # POST /fares.json
  def create
    @fare = Fare.new(fare_params)

    respond_to do |format|
      if @fare.save
        format.html { redirect_to @fare, notice: 'Fare was successfully created.' }
        format.json { render :show, status: :created, location: @fare }
      else
        format.html { render :new }
        format.json { render json: @fare.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fares/1
  # PATCH/PUT /fares/1.json
  def update
    respond_to do |format|
      if @fare.update(fare_params)
        format.html { redirect_to @fare, notice: 'Fare was successfully updated.' }
        format.json { render :show, status: :ok, location: @fare }
      else
        format.html { render :edit }
        format.json { render json: @fare.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fares/1
  # DELETE /fares/1.json
  def destroy
    @fare.destroy
    respond_to do |format|
      format.html { redirect_to fares_url, notice: 'Fare was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fare
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fare_params
      #params.require(:fare).permit(:recordid, :tip_amount, :extra, :mta_tax, :ratecodeid, :tolls_amount, :total_amount, :fare_amount, :improvement_surcharge, :payment_type)
    end
end
