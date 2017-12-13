<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		String url = "jdbc:mysql://dbinstance336.cetrc28mqdpc.us-east-2.rds.amazonaws.com:3306/HotelDatabase";
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, "group22", "group22password");
		
		
		int startmonth = Integer.parseInt(request.getParameter("startmonth").trim());
		int startday = Integer.parseInt(request.getParameter("startday").trim());
		int startyear = Integer.parseInt(request.getParameter("startyear").trim());
		int endmonth = Integer.parseInt(request.getParameter("endmonth").trim());
		int endday = Integer.parseInt(request.getParameter("endday").trim());
		int endyear = Integer.parseInt(request.getParameter("endyear").trim());
		
		int statoption2 = Integer.parseInt(request.getParameter("statoption").trim());

		boolean error = false;
		String[] statisticCheck = new String[3];
		statisticCheck[0] = "1";
		statisticCheck[1] = "1";
		statisticCheck[2] = "1";
		
		//error[0] = start date not valid
		//error[1] = end date not valid
		//error[2] = end date occurs before start date

		if (startmonth==4 || startmonth==6 || startmonth==9 || startmonth==11){
			//only 30 days in the month
			if (startday >30){
				statisticCheck[0] = "-1";
				error = true;
			}
		}
		else if (startmonth==2){
			//only 27 days
			if (startday >28){
				statisticCheck[0] = "-1";
				error = true;
			}
		}
		
		if (endmonth==4 || endmonth==6 || endmonth==9 || endmonth==11){
			//only 30 days i the month
			if (endday > 30){
				statisticCheck[1] = "-1";
				error = true;
			}
		}
		else if (endmonth==2){
			//only 27 days
			if (endday > 28){
				statisticCheck[1] = "-1";
				error = true;
			}
		}
		
		if (endyear < startyear){
			//error, year before startyear
			statisticCheck[2] = "-1";
			error = true;
		}
		else if (endyear == startyear){
			//check month
			if (endmonth < startmonth){
				//error, endmonth before startmonth
				statisticCheck[2] = "-1";
				error = true;
			}
			else if (endmonth == startmonth){
				//check day
				if (endday < startday){
					//error, endday before startday
					statisticCheck[2] = "-1";
					error = true;
				}
			}
		}

		if (error == true) {
			session.setAttribute("errors", statisticCheck);
			response.sendRedirect("statisticErr.jsp");
		} else {
			
			if (statoption2 == 1){
				// return highest rated room type for each hotel
				List<String> list = new ArrayList<String>();
			try {
				
				Statement queryStatement = con.createStatement();
				
				String getStat1 = "SELECT temp11.HotelID, temp11.RoomType, max(temp11.AvgRating) AS AvgRating " +
				"FROM(SELECT temptable3.HotelID, temptable3.RoomType, avg(temptable3.Rating) AS AvgRating " +
				"FROM( SELECT RoomReview.HotelID, Room.RoomType, RoomReview.Rating, Reserves.InDate, Reserves.Outdate " +
				"FROM RoomReview, Reserves, Reservation, Room " +
				"WHERE RoomReview.HotelID=Room.HotelID AND RoomReview.RoomNumber = Room.RoomNumber AND " +
				"RoomReview.CustomerID=Reservation.CustomerID AND Reserves.InvoiceNumber=Reservation.InvoiceNumber AND " +
				"Reserves.HotelID=Room.HotelID AND Reserves.RoomNumber=Room.RoomNumber ";

				String startDate = Integer.toString(startyear) + "/" + Integer.toString(startmonth) + "/" + Integer.toString(startday);
				String endDate =  Integer.toString(endyear) + "/" + Integer.toString(endmonth) + "/" + Integer.toString(endday);
				
				String dateSelector = "AND Reserves.OutDate between '" + startDate + "' and '" + endDate + "') temptable3 GROUP BY HotelID, RoomType) temp11 " +
				"GROUP BY HotelID";
				
				getStat1 = getStat1 + dateSelector;
				
				//out.write(getStat1);
				
				ResultSet result = queryStatement.executeQuery(getStat1);
				
				out.print("Highest rated room types for each hotel for the selected time period:");
				out.print("<p></p>");
				
				out.print("<table>");

				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//print out column header
				out.print("HotelID");
				out.print("</td>");
				
				out.print("<td>");
					out.print("RoomType");
				out.print("</td>");
				
				out.print("<td>");
					out.print("AvgRating");
				out.print("</td>");
			
				
				while (result.next()) {
					out.print("<tr>");
					
					out.print("<td>");
					out.print(result.getString("HotelID"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(result.getString("RoomType"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(result.getString("AvgRating"));
					out.print("</td>");
					
					out.print("</tr>");

				}
				out.print("</table>");

				con.close();

			} catch (Exception e) {
				
			}
						
			}
			else if (statoption2 == 2){
				//compute customers w/ 5 highest money spent
				
				List<String> list = new ArrayList<String>();
			try {
				
				Statement queryStatement = con.createStatement();
								
				
				String getStat2 = "SELECT temp1.CustomerID, temp1.Name, sum(temp1.TotalAmount) AS CustomerSum  " +
				"FROM (SELECT Reservation.CustomerID, Reservation.TotalAmount, Reservation.ReservationDate, Customer.Name " +
				"FROM Reservation, Customer WHERE Reservation.CustomerID = Customer.CustomerID AND ";						
				String startDate = Integer.toString(startyear) + "/" + Integer.toString(startmonth) + "/" + Integer.toString(startday);
				String endDate =  Integer.toString(endyear) + "/" + Integer.toString(endmonth) + "/" + Integer.toString(endday);
				
				String dateSelector = "Reservation.ReservationDate between '" + startDate + "' and '" + endDate + "') temp1 GROUP BY CustomerID ORDER BY CustomerSum DESC LIMIT 5";
				
				getStat2 = getStat2 + dateSelector;
				
				ResultSet result = queryStatement.executeQuery(getStat2);
				
				out.print("Top 5 customers for given time period:");
				out.print("<p></p>");
				
				out.print("<table>");

				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//print out column header
				out.print("CustomerID");
				out.print("</td>");
				
				out.print("<td>");
				out.print("Name");
				out.print("</td>");
				
				out.print("<td>");
					out.print("Sum Spent");
				out.print("</td>");
							
				
				while (result.next()) {
					out.print("<tr>");
					
					out.print("<td>");
					out.print(result.getString("CustomerID"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(result.getString("Name"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(result.getString("CustomerSum"));
					out.print("</td>");
										
					out.print("</tr>");

				}
				out.print("</table>");

				con.close();

			} catch (Exception e) {
				
			}
				
			}
			else if (statoption2 == 3){
				//compute highest rated breakfast type across all hotels
				
				List<String> list = new ArrayList<String>();
			try {
				
				Statement queryStatement = con.createStatement();
				
				String getStat3 = "SELECT tempbftable.BreakfastType, avg(tempbftable.Rating) AS AvgRating " +
				"FROM(SELECT Reservation.CustomerID, Reserves.InDate, Reserves.OutDate, Reserves.InvoiceNumber, " +
				"BreakfastReview.BreakfastType, BreakfastReview.Rating FROM BreakfastReview, Reserves, Reservation " +
				"WHERE BreakfastReview.CustomerID=Reservation.CustomerID AND Reservation.InvoiceNumber=Reserves.InvoiceNumber AND ";
						
				String startDate = Integer.toString(startyear) + "/" + Integer.toString(startmonth) + "/" + Integer.toString(startday);
				String endDate =  Integer.toString(endyear) + "/" + Integer.toString(endmonth) + "/" + Integer.toString(endday);
				
				String dateSelector = "Reserves.OutDate between '" + startDate + "' and '" + endDate + "') tempbftable GROUP BY BreakfastType ORDER BY AvgRating DESC";
				
				getStat3 = getStat3 + dateSelector;
				
				ResultSet result = queryStatement.executeQuery(getStat3);
				
				out.print("Average Breakfast Ratings (sorted highest to lowest):");
				out.print("<p></p>");
				
				out.print("<table>");

				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//print out column header
				out.print("Breakfast Type");
				out.print("</td>");
				
				out.print("<td>");
				out.print("Avg Rating");
				out.print("</td>");
				
							
				
				while (result.next()) {
					out.print("<tr>");
					
					out.print("<td>");
					out.print(result.getString("BreakfastType"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(result.getString("AvgRating"));
					out.print("</td>");
					
										
					out.print("</tr>");

				}
				out.print("</table>");

				con.close();

			} catch (Exception e) {
				
			}
				
			}
			else if (statoption2 == 4){
				//compute highest rated service type across all hotels
				
				List<String> list = new ArrayList<String>();
			try {
				
				Statement queryStatement = con.createStatement();
				
				String getStat4 = "SELECT temptable.ServiceType, avg(temptable.Rating) AS AvgRating " +
				"FROM(SELECT Reservation.CustomerID, Reserves.InDate, Reserves.OutDate, Reserves.InvoiceNumber, " +
				"ServiceReview.ServiceType, ServiceReview.Rating FROM ServiceReview, Reserves, Reservation " +
				"WHERE ServiceReview.CustomerID=Reservation.CustomerID AND Reservation.InvoiceNumber=Reserves.InvoiceNumber AND ";
						
				String startDate = Integer.toString(startyear) + "/" + Integer.toString(startmonth) + "/" + Integer.toString(startday);
				String endDate =  Integer.toString(endyear) + "/" + Integer.toString(endmonth) + "/" + Integer.toString(endday);
				
				String dateSelector = "Reserves.OutDate between '" + startDate + "' and '" + endDate + "') temptable GROUP BY ServiceType ORDER BY AvgRating DESC";
				
				getStat4 = getStat4 + dateSelector;
				
				ResultSet result = queryStatement.executeQuery(getStat4);
				
				out.print("Average Service Ratings (sorted highest to lowest):");
				out.print("<p></p>");
				
				out.print("<table>");

				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//print out column header
				out.print("Service Type");
				out.print("</td>");
				
				out.print("<td>");
				out.print("Avg Rating");
				out.print("</td>");
				
							
				
				while (result.next()) {
					out.print("<tr>");
					
					out.print("<td>");
					out.print(result.getString("ServiceType"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(result.getString("AvgRating"));
					out.print("</td>");
					
										
					out.print("</tr>");

				}
				out.print("</table>");

				con.close();

			} catch (Exception e) {
				
			}
				
				
				
				
				
				
				
				
				
			}
			
			
		}
	%>
	
	<p></p>
	<p></p>
	Return to the statistic selector here:
	<br>
	

	<form method="get" action="../Statistics/selectStatistic.jsp" enctype=text/plain>
		<input type="submit" value="Choose another statistic">
	</form>

<p></p>
<p></p>
Return to home page here:
<br>
<form method="get" action="../Home.jsp" enctype=text/plain>
<input type="submit" value="Home">
</form>


</body>
</html>