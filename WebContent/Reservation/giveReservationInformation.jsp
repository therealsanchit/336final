<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Reservation</title>
</head>
<body>
	<%
		String url = "jdbc:mysql://dbinstance336.cetrc28mqdpc.us-east-2.rds.amazonaws.com:3306/HotelDatabase";
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, "group22", "group22password");

		String room, inDay, inMonth, inYear, outDay, outMonth, outYear, services, breakfast;
		room = request.getParameter("roomType");
		String[] roomInfo = room.split(",");
		inDay = request.getParameter("inDay");
		inMonth = request.getParameter("inMonth");
		inYear = request.getParameter("inYear");
		outDay = request.getParameter("outDay");
		outMonth = request.getParameter("outMonth");
		outYear = request.getParameter("outYear");
		services = request.getParameter("services");
		String[] serviceInfo = services.split(";");
		breakfast = request.getParameter("breakfast");
		String[] breakfastInfo = breakfast.split(";");

		String customerID = (String) session.getAttribute("customerID");
		String hotelID = (String) session.getAttribute("hid");

		if (inMonth.length() == 1)
			inMonth = "0".concat(inMonth);

		if (inDay.length() == 1)
			inDay = "0".concat(inDay);

		if (outMonth.length() == 1)
			outMonth = "0".concat(outMonth);

		if (outDay.length() == 1)
			outDay = "0".concat(outDay);

		String inDate = inYear + "-" + inMonth + "-" + inDay;
		String outDate = outYear + "-" + outMonth + "-" + outDay;

		System.out.println(inDate);
		System.out.println(outDate);
		
		System.out.println(services);
		System.out.println(breakfast);
		
		
		double finalServicePrice=0;
		double finalBreakfastPrice=0;
		
		
		
		
		
		String isDiscount = "Select * From Room Where HotelID = ? And RoomType=?";
		PreparedStatement dQuery = con.prepareStatement(isDiscount);
		dQuery.setString(1, hotelID);
		dQuery.setString(2, roomInfo[0]);
		ResultSet result = dQuery.executeQuery();

		boolean discount = false;
		String percent="";
		String price="";
		while(result.next()){
			String startDate = result.getString("StartDate");
			if(startDate.equals(inDate)){
				discount = true;
				percent = result.getString("Discount");
				price = result.getString("Price");
				break;
			}
				
		}
		
		double finalRoomPrice = Double.parseDouble(percent) * Double.parseDouble(price);
		
		if(discount == true){
			out.write("There is a discount available: " + percent);
			out.write("<br>");
			out.write("Price of room is: " + finalRoomPrice);
			out.write("<br>");
		}
		
		
		
		
		
	%>
</body>
</html>