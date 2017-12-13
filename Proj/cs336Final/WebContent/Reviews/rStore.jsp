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

		int rNum = Integer.parseInt(request.getParameter("rNum"));
		float rRating = Float.valueOf(request.getParameter("rRating"));
		String rComment = request.getParameter("rComment");
		

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
				
				
			
				String insert = "INSERT INTO RoomReview(ReviewID, Rating, TextComment)"
					+ "VALUES (?, ?, ?)";

				PreparedStatement ps = con.prepareStatement(insert);
			
				int reviewID=10;
				int hotelID=7;
				
				ps.setInt(1, reviewID);
				//ps.setInt(2, rNum);
				//ps.setInt(3, hotelID);
				ps.setFloat(2, rRating);
				ps.setString(3, rComment);

				ps.executeUpdate();
				
				
			}
		
	%>
	Thank you for Room Review!!!
</body>
</html>