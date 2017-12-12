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
			if (startday >27){
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
			if (endmonth > 27){
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
			
			List<String> list = new ArrayList<String>();

			try {

				
				
				Statement queryStatement = con.createStatement();
				
				String getStat1 = "SELECT temptable3.HotelID, temptable3.RoomType, avg(temptable3.Rating) AS AvgRating FROM(" +
					"SELECT RoomReview.HotelID, Room.RoomType, RoomReview.Rating, Reserves.InDate, Reserves.Outdate " +
					"FROM RoomReview, Reserves, Reservation, Room " +
					"WHERE RoomReview.HotelID = Room.HotelID AND RoomReview.RoomNumber = Room.RoomNumber AND " +
					"RoomReview.CustomerID = Reservation.CustomerID AND Reserves.InvoiceNumber = Reservation.InvoiceNumber AND " +
					"Reserves.HotelID = Room.HotelID AND Reserves.RoomNumber = Room.RoomNumber ";
				
				String startDate = Integer.toString(startyear) + "/" + Integer.toString(startmonth) + "/" + Integer.toString(startday);
				String endDate =  Integer.toString(endyear) + "/" + Integer.toString(endmonth) + "/" + Integer.toString(endday);
				
				String dateSelector = "AND Reserves.OutDate between '" + startDate + "' and '" + endDate + "') temptable3 GROUP BY HotelID, RoomType";
				
				getStat1 = getStat1 + dateSelector;
				
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
	%>
	Thank you for registering, Please login here:
	<br>
	

	<form method="get" action="../showStatistic.jsp" enctype=text/plain>
		<input type="submit" value="Check database">
	</form>



</body>
</html>