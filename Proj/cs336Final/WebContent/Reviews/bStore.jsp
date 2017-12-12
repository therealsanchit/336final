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
		String bRating = request.getParameter("bRating");
		String bComment = request.getParameter("bComment");
		

		boolean error = false;
		String[] breakfastCheck = new String[3];

		if (bType.trim().length() > 50) {
			breakfastCheck[0] = "-1";
			error = true;
		} else
			breakfastCheck[0] = "1";
		
		if (!(bRating.equals("1") || bRating.equals("2") || bRating.equals("3") || bRating.equals("4") || bRating.equals("5") || bRating.equals("6") || bRating.equals("7") || bRating.equals("8") || bRating.equals("9") || bRating.equals("10"))) {
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

				String insert = "INSERT INTO BreakfatReview(ReviewID, BreakfastType, HotelID, Rating, TextComment)"
						+ "VALUES (?, ?, ?, ?, ?)";

				PreparedStatement ps = con.prepareStatement(insert);

				ps.setString(1, "24204");
				ps.setString(2, bType);
				ps.setString(3, "4243");
				ps.setString(4, bRating);
				ps.setString(5, bComment);
				ps.executeUpdate();
			}
		
	%>
	Thank you for Breakfast Review!!!
</body>
</html>