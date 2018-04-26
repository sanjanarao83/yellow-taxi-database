class FaresController < ApplicationController
  before_action :set_fare, only: [:show, :edit, :update, :destroy]

  # GET /fares
  # GET /fares.json
  def index
  end

  def view
    session[:passed_variable] = nil
    request = params[:request]
    faremonth = params[:month]
    fareyear = params[:year]
    if !fareyear || fareyear.nil? || fareyear.empty? then
      fareyear = "2017"
    end

    if request == "getTotalTrips" then
      if !faremonth || faremonth.nil? || faremonth.empty? then
        query = "SELECT TO_CHAR(PICKUP_DATETIME, 'mm') AS \"Month\", COUNT(RECORDID) AS \"Total Trips\" FROM TRIP_DATA 
                WHERE TO_CHAR(PICKUP_DATETIME, 'YYYY')= " + fareyear + "
                GROUP BY TO_CHAR(PICKUP_DATETIME, 'mm')
                ORDER BY TO_CHAR(PICKUP_DATETIME, 'mm') DESC"
      else
        query = "SELECT TO_CHAR(PICKUP_DATETIME, 'mm') AS \"Month\", COUNT(RECORDID) AS \"Total Trips\" FROM TRIP_DATA 
                WHERE TO_CHAR(PICKUP_DATETIME, 'YYYY')= " + fareyear + " AND
                TO_CHAR(PICKUP_DATETIME, 'mm')= " + faremonth + "
                GROUP BY TO_CHAR(PICKUP_DATETIME, 'mm')
                ORDER BY TO_CHAR(PICKUP_DATETIME, 'mm') DESC"
      end
    elsif request == "getMaxTollAmt" then
        query = "SELECT TRIP_DISTANCE, FARE_DATA.TOLLS_AMOUNT FROM TRIP_DATA, FARE_DATA 
                WHERE TRIP_DATA.RECORDID = FARE_DATA.RECORDID AND 
                TRIP_DATA.RECORDID = (SELECT RECORDID FROM FARE_DATA 
                WHERE TOLLS_AMOUNT = (SELECT MAX(TOLLS_AMOUNT) FROM FARE_DATA))"
    elsif request == "getDifferenceInFareAmt" then
        query = "SELECT A.Year, A.MONTH AS Month, A.TRIP_DISTANCE as \"Trip Distance\", 
                A.FARE_AMOUNT as \"Fare Amount 1\", B.FARE_AMOUNT as \"Fare Amount 2\", (A.FARE_AMOUNT - B.FARE_AMOUNT) as \"Difference\" FROM
                (SELECT TRIP_DATA.RECORDID, TRIP_DATA.TRIP_DISTANCE, TO_CHAR(PICKUP_DATETIME, 'MON') Month, TO_CHAR(PICKUP_DATETIME, 'YYYY') Year, FARE_DATA.FARE_AMOUNT FROM TRIP_DATA, FARE_DATA
                WHERE TRIP_DATA.RECORDID = FARE_DATA.RECORDID AND
                FARE_DATA.PAYMENT_TYPE = 1 AND
                FARE_DATA.FARE_AMOUNT > 30 AND
                TO_CHAR(PICKUP_DATETIME, 'YYYY')= " + fareyear + ") A, 
                (SELECT TRIP_DATA.RECORDID, TRIP_DATA.TRIP_DISTANCE, TO_CHAR(PICKUP_DATETIME, 'MON') Month, TO_CHAR(PICKUP_DATETIME, 'YYYY') Year, FARE_DATA.FARE_AMOUNT FROM TRIP_DATA, FARE_DATA
                WHERE TRIP_DATA.RECORDID = FARE_DATA.RECORDID AND
                FARE_DATA.PAYMENT_TYPE = 1 AND
                FARE_DATA.FARE_AMOUNT > 30 AND
                TO_CHAR(PICKUP_DATETIME, 'YYYY')= " + fareyear + ") B
                WHERE A.TRIP_DISTANCE = B.TRIP_DISTANCE AND
                A.Month = B.Month AND
                A.RECORDID <> B.RECORDID
                ORDER BY A.Month DESC"
    elsif request == "getTotalPickups" then
        if !faremonth || faremonth.nil? || faremonth.empty? then

        else
          query = "WITH ABCD AS
                (SELECT TO_CHAR(PICKUP_DATETIME, 'MON') AS Mon, ROUND(TO_CHAR(LOCATION_DATA.PICKUP_LATITUDE), 4) Latitude, 
                ROUND(TO_CHAR(LOCATION_DATA.PICKUP_LONGITUDE), 4) Longitude, COUNT(TRIP_DATA.RECORDID) Totaltrips, SUM(FARE_DATA.TOTAL_AMOUNT) TotalAmount
                FROM TRIP_DATA, FARE_DATA, LOCATION_DATA
                WHERE TRIP_DATA.RECORDID = FARE_DATA.RECORDID AND
                TRIP_DATA.RECORDID = LOCATION_DATA.RECORDID AND
                TO_CHAR(TRIP_DATA.PICKUP_DATETIME, 'YYYY')= " + fareyear + " AND
                TO_CHAR(TRIP_DATA.PICKUP_DATETIME, 'mm')= " + faremonth + " AND
                LOCATION_DATA.PICKUP_LONGITUDE <> 0 AND LOCATION_DATA.PICKUP_LATITUDE <> 0
                GROUP BY TO_CHAR(TRIP_DATA.PICKUP_DATETIME, 'MON'), ROUND(TO_CHAR(LOCATION_DATA.PICKUP_LATITUDE), 4), ROUND(TO_CHAR(LOCATION_DATA.PICKUP_LONGITUDE), 4)
                ORDER BY Mon, Totaltrips DESC)
                SELECT Mon \"Month\", Latitude, Longitude, Totaltrips AS \"Maximum Trips\", TotalAmount AS \"Total Amount\" FROM ABCD A
                WHERE Totaltrips = (SELECT MAX(Totaltrips) FROM ABCD WHERE ABCD.Mon = A.Mon)"
        end
    elsif request == "getTotalDropOffs" then
        if !faremonth || faremonth.nil? || faremonth.empty? then
          
        else
          query = "WITH ABCD AS
                (SELECT TO_CHAR(DROPOFF_DATETIME, 'MON') AS Mon, ROUND(TO_CHAR(LOCATION_DATA.DROPOFF_LATITUDE), 4) Latitude, 
                ROUND(TO_CHAR(LOCATION_DATA.DROPOFF_LONGITUDE), 4) Longitude, COUNT(TRIP_DATA.RECORDID) Totaltrips, SUM(FARE_DATA.TOTAL_AMOUNT) TotalAmount
                FROM TRIP_DATA, FARE_DATA, LOCATION_DATA
                WHERE TRIP_DATA.RECORDID = FARE_DATA.RECORDID AND
                TRIP_DATA.RECORDID = LOCATION_DATA.RECORDID AND
                TO_CHAR(TRIP_DATA.DROPOFF_DATETIME, 'YYYY')= " + fareyear + " AND
                TO_CHAR(TRIP_DATA.DROPOFF_DATETIME, 'mm')= " + faremonth + " AND
                LOCATION_DATA.DROPOFF_LONGITUDE <> 0 AND LOCATION_DATA.DROPOFF_LATITUDE <> 0
                GROUP BY TO_CHAR(TRIP_DATA.DROPOFF_DATETIME, 'MON'), ROUND(TO_CHAR(LOCATION_DATA.DROPOFF_LATITUDE), 4), ROUND(TO_CHAR(LOCATION_DATA.DROPOFF_LONGITUDE), 4)
                ORDER BY Mon, Totaltrips DESC)
                SELECT Mon AS \"Month\", Latitude, Longitude, Totaltrips AS \"Maximum Trips\", TotalAmount AS \"Total Amount\" FROM ABCD A
                WHERE Totaltrips = (SELECT MAX(Totaltrips) FROM ABCD WHERE ABCD.Mon = A.Mon)"
        end
    elsif request == "getRoundTrips" then
        query = "SELECT TO_CHAR(PICKUP_DATETIME, 'MON') AS \"Month\", COUNT(DISTINCT T.RECORDID) AS \"Total Round Trips\"
                FROM SANJANA.LOCATION_DATA L JOIN SANJANA.TRIP_DATA T
                ON T.RECORDID = L.RECORDID
                WHERE PICKUP_LATITUDE = DROPOFF_LATITUDE
                AND PICKUP_LONGITUDE = DROPOFF_LONGITUDE
                AND DROPOFF_LATITUDE <> 0
                AND PICKUP_LATITUDE <> 0
                AND PICKUP_LONGITUDE <> 0
                AND DROPOFF_LONGITUDE <> 0
                AND extract(YEAR from PICKUP_DATETIME) = " + fareyear + "
                GROUP BY TO_CHAR(PICKUP_DATETIME, 'MON')"
    elsif request == "getPaymentType" then
        query = "SELECT CASE PAYMENT_TYPE 
                WHEN 1 THEN 'Credit Card' 
                WHEN 2 THEN 'Cash' 
                WHEN 3 THEN 'No charge'
                WHEN 4 THEN 'Dispute'
                WHEN 5 THEN 'Unknown'
                ELSE 'Voided Trip' END AS \"Payment Type\", COUNT(FARE_DATA.PAYMENT_TYPE) AS \"Total payments\"
                FROM FARE_DATA
                GROUP BY PAYMENT_TYPE"
    elsif request == "getTripsBasedOnTime" then
        query = "select 'Early Morning' AS \"Time of the day\", COUNT(DISTINCT RECORDID) AS \"Total trips\"
                from TRIP_DATA
                where to_char(TRIP_DATA.PICKUP_DATETIME, 'hh24:mi:ss') > '01:00:00' 
                and to_char(TRIP_DATA.PICKUP_DATETIME, 'hh24:mi:ss') <= '05:00:00'
                UNION
                select 'Morning' AS \"Time of the day\", COUNT(DISTINCT RECORDID) AS \"Total trips\"
                from TRIP_DATA
                where to_char(TRIP_DATA.PICKUP_DATETIME, 'hh24:mi:ss') > '05:00:00' 
                and to_char(TRIP_DATA.PICKUP_DATETIME, 'hh24:mi:ss') <= '11:59:59'
                UNION
                select 'Afternoon' AS \"Time of the day\", COUNT(DISTINCT RECORDID) AS \"Total trips\"
                from TRIP_DATA
                where to_char(TRIP_DATA.PICKUP_DATETIME, 'hh24:mi:ss') > '11:59:59' 
                and to_char(TRIP_DATA.PICKUP_DATETIME, 'hh24:mi:ss') <= '16:00:00'
                UNION
                select 'Evening' AS \"Time of the day\", COUNT(DISTINCT RECORDID) AS \"Total trips\"
                from TRIP_DATA
                where to_char(TRIP_DATA.PICKUP_DATETIME, 'hh24:mi:ss') > '16:00:00' 
                and to_char(TRIP_DATA.PICKUP_DATETIME, 'hh24:mi:ss') <= '20:00:00'
                UNION
                select 'Night' AS \"Time of the day\", COUNT(DISTINCT RECORDID) AS \"Total trips\"
                from TRIP_DATA
                where to_char(TRIP_DATA.PICKUP_DATETIME, 'hh24:mi:ss') > '20:00:00' 
                and to_char(TRIP_DATA.PICKUP_DATETIME, 'hh24:mi:ss') <= '01:00:00'"
    else
      query = "SELECT COUNT(DISTINCT RECORDID) AS \"Total No of Tuples in the DB\" FROM TRIP_DATA"
    end

    conn = OCI8.new('sanjana', 'Srvrtvk83!', 'oracle.cise.ufl.edu/orcl')
    @fares = []
      
    cursor = conn.parse(query)
    cursor.exec
    while r = cursor.fetch_hash
      @fares << r
    end
    conn.logoff  
    if !@fares.nil? && !@fares.empty? then
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

  def destroy
    cookies.delete(@fares)
    reset_session
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
=======
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
