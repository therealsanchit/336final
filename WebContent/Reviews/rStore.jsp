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
		String customerID = (String)session.getAttribute("customerID");
		int cid = Integer.parseInt(customerID);
		
		int rNum = Integer.parseInt(request.getParameter("rNum"));
		float rRating = Float.valueOf(request.getParameter("rRating"));
		String rComment = request.getParameter("rComment");
		
		//Get invoice number for the customer
		String invoiceID = "Select InvoiceNumber FROM Reservation WHERE CustomerID=?";
		PreparedStatement sqlQuery = con.prepareStatement(invoiceID);
		sqlQuery.setString(1, customerID);
		ResultSet result = sqlQuery.executeQuery();
		
		//Use the invoice number to get the hotelID
		String hotelID2= "Select hotelID FROM Reserves WHERE InvoiceNumber=?";
		PreparedStatement sqlQuery2 = con.prepareStatement(hotelID2);
		sqlQuery2.setString(1, invoiceID);
		ResultSet result2 = sqlQuery2.executeQuery();
		try{
			int hotelID=Integer.parseInt(hotelID2);//Convert to an integer
			}catch(NumberFormatException ex){
				response.sendRedirect("showOptions.jsp");
			}
		
		String reviewID2= "Select Count(*) FROM RoomReview";
		PreparedStatement sqlQuery3 = con.prepareStatement(reviewID2);
		ResultSet result3 = sqlQuery3.executeQuery();
		int reviewID=Integer.parseInt(reviewID2); //Convert to an integer
		reviewID++;
		
		boolean error = false;
		String[] roomCheck = new String[3];

	
		if (!(rRating>=0 && rRating<11)) {
			roomCheck[1] = "-1";
			error = true;
		} else
			roomCheck[1] = "1";
		if (rComment.trim().length() > 100) {
			roomCheck[2] = "-1";
			error = true;
		} else
			roomCheck[2] = "1";
		
		if (error == true) {
			response.sendRedirect("roomReview");
		} else {
				
				String insert = "INSERT INTO RoomReview(ReviewID, RoomNumber, HotelID, Rating, TextComment, CustomerID)"
					+ "VALUES (?, ?, ?, ?, ?, ?)";

				PreparedStatement ps = con.prepareStatement(insert);
			
		
				ps.setInt(1, reviewID);
				ps.setInt(2, rNum);
				ps.setInt(3, hotelID)
				ps.setFloat(4, rRating);
				ps.setString(5, rComment);
				ps.setInt(6, cid);

				ps.executeUpdate();
				
				
			}
		
	%>
	Thank you for Room Review!!!
</body>
</html>