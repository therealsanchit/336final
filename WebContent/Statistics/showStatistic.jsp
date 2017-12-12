<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Displaying Statistics</title>
</head>
<body>
	<%
		List<String> list = new ArrayList<String>();

		try {

			//Create a connection string
			String url = "jdbc:mysql://dbinstance336.cetrc28mqdpc.us-east-2.rds.amazonaws.com:3306/HotelDatabase";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");

			//Create a connection to your DB
			Connection con = DriverManager.getConnection(url, "group22", "group22password");
			
			Statement queryStatement = con.createStatement();
			
			String getStat1 = "SELECT temptable3.HotelID, temptable3.RoomType, avg(temptable3.Rating) AS AvgRating FROM(" +
				"SELECT RoomReview.HotelID, Room.RoomType, RoomReview.Rating, Reserves.InDate, Reserves.Outdate " +
				"FROM RoomReview, Reserves, Reservation, Room " +
				"WHERE RoomReview.HotelID = Room.HotelID AND RoomReview.RoomNumber = Room.RoomNumber AND " +
				"RoomReview.CustomerID = Reservation.CustomerID AND Reserves.InvoiceNumber = Reservation.InvoiceNumber AND " +
				"Reserves.HotelID = Room.HotelID AND Reserves.RoomNumber = Room.RoomNumber) temptable3 " +
			"GROUP BY HotelID, RoomType";
			
			ResultSet result = queryStatement.executeQuery(getStat1);
			
			
			
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
	%>

</body>
</html>