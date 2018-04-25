class FaresController < ApplicationController
  before_action :set_fare, only: [:show, :edit, :update, :destroy]

  # GET /fares
  # GET /fares.json
  def index
      conn = OCI8.new('sanjana', 'Srvrtvk83!', 'oracle.cise.ufl.edu/orcl')
      @fares = []
      query = "SELECT * FROM TRIP_DATA WHERE ROWNUM < 10"
      cursor = conn.parse(query)
      cursor.exec
      while r = cursor.fetch_hash
        @fares << r
      end
      conn.logoff
  end

  def onMonthSelect
    faremonth = params[:month]
    fareyear = params[:year]
    if !fareyear then
      fareyear = 2017
    end
    if !faremonth then
      faremonth = 12
    end
    if faremonth then
      conn = OCI8.new('sanjana', 'Srvrtvk83!', 'oracle.cise.ufl.edu/orcl')
      @fares = []
      query = "SELECT VENDORID, PICKUP_DATETIME, DROPOFF_DATETIME, PASSENGER_COUNT, TRIP_DISTANCE FROM TRIP_DATA WHERE TO_CHAR(PICKUP_DATETIME, 'MM')=" + faremonth + " AND TO_CHAR(PICKUP_DATETIME, 'YYYY')= " + fareyear + " AND ROWNUM < 10"
      cursor = conn.parse(query)
      cursor.exec
      while r = cursor.fetch_hash
        @fares << r
      end
      puts "**********************************************************************************************"
      puts @fares
      conn.logoff  
    end
    if @fares then
      session[:passed_variable] = @fares
      redirect_to "/fares/show"
    else
      #TODO alert no data
    end
  end

  def show 
    @fares = session[:passed_variable]
    puts @fares
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
