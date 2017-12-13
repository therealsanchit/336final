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
		

		boolean error = false;
		String[] breakfastCheck = new String[3];

		if (bType.trim().length() > 50) {
			breakfastCheck[0] = "-1";
			error = true;
		} else
			breakfastCheck[0] = "1";
		//
		//if (!(bRating.equals("1") || bRating.equals("2") || bRating.equals("3") || bRating.equals("4") || bRating.equals("5") || bRating.equals("6") || bRating.equals("7") || bRating.equals("8") || bRating.equals("9") || bRating.equals("10"))) {
			//breakfastCheck[1] = "-1";
			//error = true;
		//} else
			//breakfastCheck[1] = "1";
		if (bComment.trim().length() > 100) {
			breakfastCheck[2] = "-1";
			error = true;
		} else
			breakfastCheck[2] = "1";
		
		if (error == true) {
			response.sendRedirect("breakfastReview");
		} else {
			
			// FINALCID VARIABLE NEEDS TO PULL FROM customerLogin.jsp FORM TO GET THE CUSTOMER ID
			// BELOW
			// USES THAT CUSTOMER ID TO INSERT INTO THE DATABASE
			// WITHOUT IT A FOREIGN KEY CONTRAINT FAILS
			// I added a system.print.ln so if it prints null in the console you didn't pass the value properly
			
			String finalcid = request.getParameter("cid");
			int finalcidint = Integer.parseInt(finalcid.trim());
			
			System.out.println(finalcidint);
			
				
				String insert = "INSERT INTO BreakfastReview(BreakfastType, HotelID, Rating, TextComment, CustomerID)"
					+ "VALUES (?, ?, ?, ?, ?)";

				PreparedStatement ps = con.prepareStatement(insert);
			
				int hotelID=4;
				
				ps.setString(1, bType);
				ps.setInt(2, hotelID);
				ps.setFloat(3, bRating);
				ps.setString(4, bComment);
				ps.setInt(5, finalcidint);
				

				ps.executeUpdate();
				
				
			}
		
	%>
	Thank you for Breakfast Review!!!
</body>
</html>