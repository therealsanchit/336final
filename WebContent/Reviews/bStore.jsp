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

		String bType = request.getParameter("bType");
		float bRating = Float.valueOf(request.getParameter("bRating"));
		String bComment = request.getParameter("bComment");
		
		String customerID = (String)session.getAttribute("customerID");
		int cid = Integer.parseInt(customerID);
		
		//Get invoice number for the customer
		String invoiceID = "Select InvoiceNumber FROM Reservation WHERE CustomerID=?";
		PreparedStatement sqlQuery = con.prepareStatement(invoiceID);
		sqlQuery.setString(1, customerID);
		ResultSet result = sqlQuery.executeQuery();
		
		//Use the invoice number to get the hotelID
		String hotelID2= "Select hotelID as hID FROM Reserves WHERE InvoiceNumber=?";
		PreparedStatement sqlQuery2 = con.prepareStatement(hotelID2);
		sqlQuery2.setString(1, invoiceID);
		ResultSet result2 = sqlQuery2.executeQuery();
		try{
		int hotelID=Integer.parseInt(hotelID2);//Convert to an integer
		}catch(NumberFormatException ex){
			response.sendRedirect("showOptions.jsp");
		}
		//Now we have the hotel ID from where the customer stayed

		
		String reviewID2= "Select Count(*) as cnt FROM BreakfastReview";
		PreparedStatement sqlQuery3 = con.prepareStatement(reviewID2);
		ResultSet result3 = sqlQuery3.executeQuery();
		int reviewID=result3.getInt("cnt"); //Convert to an integer
		reviewID++;
		
		
		
		//Error checking for the user input
		boolean error = false;
		String[] breakfastCheck = new String[3];

		if (bType.trim().length() > 50) {
			breakfastCheck[0] = "-1";
			error = true;
		} else
			breakfastCheck[0] = "1";
		
		if (!(bRating>=0 && bRating<=10)) {
			breakfastCheck[1] = "-1";
			error = true;
		} else
			breakfastCheck[1] = "1";
		if (bComment.trim().length() > 100) {
			breakfastCheck[2] = "-1";
			error = true;
		} else
			breakfastCheck[2] = "1";
		
		if (error == true) {
			response.sendRedirect("breakfastReview");
		} else {
					
				String insert = "INSERT INTO BreakfastReview(BreakfastType, HotelID, Rating, TextComment, CustomerID)"
					+ "VALUES (?, ?, ?, ?, ?, ?)";

				PreparedStatement ps = con.prepareStatement(insert);
				
				ps.setInt(1,reviewID);
				ps.setString(2, bType);
				ps.setInt(3, hotelID);
				ps.setFloat(4, bRating);
				ps.setString(5, bComment);
				ps.setInt(6, cid);
				
				ps.executeUpdate();
				
			}
		
	%>
	Thank you for Breakfast Review!!!
</body>
</html>