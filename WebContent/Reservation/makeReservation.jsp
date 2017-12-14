<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

		String hid = request.getParameter("hid");

		out.write("Choose a room type: ");

		out.write("<br>");
		ArrayList<String> roomType = new ArrayList<String>();
		ArrayList<String> roomCost = new ArrayList<String>();
		String getRooms = "Select * FROM Room where HotelID = ?";
		PreparedStatement roomQuery = con.prepareStatement(getRooms);
		roomQuery.setString(1, hid);
		ResultSet result = roomQuery.executeQuery();

		while (result.next()) {
			if (!roomType.contains(result.getString("RoomType"))){
				roomType.add(result.getString("RoomType"));
				roomCost.add(result.getString("Price"));
			}
		}

		out.write("<span>");
		out.write("<select name = 'selectRoom' id = 'roomSpan'>");
		for (int i = 0; i < roomType.size(); i++) {
			out.write("<option value = '" + i + "'>");
			out.write(roomType.get(i));
			out.write(", Cost: ");
			out.write(roomCost.get(i));
			out.write("</option>");
		}
		out.write("</select>");
		out.write("</span>");
	%>

	<br>
	<br> Choose check-in date:
	<span> <select name="checkInMonth" id="inMonth">
			<option value="1">January</option>
			<option value="2">February</option>
			<option value="3">March</option>
			<option value="4">April</option>
			<option value="5">May</option>
			<option value="6">June</option>
			<option value="7">July</option>
			<option value="8">August</option>
			<option value="9">September</option>
			<option value="10">October</option>
			<option value="11">November</option>
			<option value="12">December</option>
	</select>
	</span>

	<span> <select name="checkInDay" id="inDay">
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
			<option value="6">6</option>
			<option value="7">7</option>
			<option value="8">8</option>
			<option value="9">9</option>
			<option value="10">10</option>
			<option value="11">11</option>
			<option value="12">12</option>
			<option value="13">13</option>
			<option value="14">14</option>
			<option value="15">15</option>
			<option value="16">16</option>
			<option value="17">17</option>
			<option value="18">18</option>
			<option value="19">19</option>
			<option value="20">20</option>
			<option value="21">21</option>
			<option value="22">22</option>
			<option value="23">23</option>
			<option value="24">24</option>
			<option value="25">25</option>
			<option value="26">26</option>
			<option value="27">27</option>
			<option value="28">28</option>
			<option value="29">29</option>
			<option value="30">30</option>
			<option value="31">31</option>
	</select>
	</span>
	<span> <select name="checkInYear" id="inYear">
			<option value="2018">2018</option>
			<option value="2017">2017</option>
	</select>
	</span>


	<br>
	<br> Choose check-out date:
	<span> <select name="checkOutMonth" id="outMonth">
			<option value="1">January</option>
			<option value="2">February</option>
			<option value="3">March</option>
			<option value="4">April</option>
			<option value="5">May</option>
			<option value="6">June</option>
			<option value="7">July</option>
			<option value="8">August</option>
			<option value="9">September</option>
			<option value="10">October</option>
			<option value="11">November</option>
			<option value="12">December</option>
	</select>
	</span>

	<span> <select name="checkOutDay" id="outDay">
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
			<option value="6">6</option>
			<option value="7">7</option>
			<option value="8">8</option>
			<option value="9">9</option>
			<option value="10">10</option>
			<option value="11">11</option>
			<option value="12">12</option>
			<option value="13">13</option>
			<option value="14">14</option>
			<option value="15">15</option>
			<option value="16">16</option>
			<option value="17">17</option>
			<option value="18">18</option>
			<option value="19">19</option>
			<option value="20">20</option>
			<option value="21">21</option>
			<option value="22">22</option>
			<option value="23">23</option>
			<option value="24">24</option>
			<option value="25">25</option>
			<option value="26">26</option>
			<option value="27">27</option>
			<option value="28">28</option>
			<option value="29">29</option>
			<option value="30">30</option>
			<option value="31">31</option>
	</select>
	</span>
	<span> <select name="checkOutYear" id="outYear">
			<option value="2018">2018</option>
			<option value="2017">2017</option>
	</select>
	</span>

	<br>
	<br>
	<%
		out.write("Hotel provides the following services. Choose: ");

		ArrayList<String> serviceType = new ArrayList<String>();
		ArrayList<String> serviceCost = new ArrayList<String>();
		String getServices = "Select * FROM Service where HotelID = ?";
		PreparedStatement serviceQuery = con.prepareStatement(getServices);
		serviceQuery.setString(1, hid);
		result = serviceQuery.executeQuery();

		while (result.next()) {
			if (!serviceType.contains(result.getString("ServiceType"))) {
				serviceType.add(result.getString("ServiceType"));
				serviceCost.add(result.getString("ServicePrice"));
			}
		}
		
		String serviceSize = Integer.toString(serviceType.size());

		out.write("<fieldset>");
		for (int i = 0; i < serviceType.size(); i++) {
			out.write("<input type = 'radio' name = '" + serviceType.get(i) + "' id = '" + i
					+ "' value = '" + serviceType.get(i) + " " + serviceCost.get(i) + "'/>");
			out.write("<label for = '" + serviceType.get(i) + "'>");
			out.write(serviceType.get(i));
			out.write(", Costs: ");
			out.write(serviceCost.get(i));
			out.write("$");
			out.write("</label><br />");
		}
		out.write("</fieldset>");

		out.write("Hotel provides the following breakfasts. Enter # of orders: ");

		ArrayList<String> breakfastType = new ArrayList<String>();
		ArrayList<String> breakfastCost = new ArrayList<String>();
		String getBreakfast = "Select * FROM Breakfast where HotelID = ?";
		PreparedStatement breakfastQuery = con.prepareStatement(getBreakfast);
		breakfastQuery.setString(1, hid);
		result = breakfastQuery.executeQuery();

		while (result.next()) {
			if (!breakfastType.contains(result.getString("BreakfastType"))) {
				breakfastType.add(result.getString("BreakfastType"));
				breakfastCost.add(result.getString("BreakfastPrice"));
			}
		}
		
		String breakfastSize = Integer.toString(breakfastType.size());


		out.write("<fieldset>");
		for (int i = 0; i < breakfastType.size(); i++) {
			out.write("<input type = 'text' name = '" + breakfastType.get(i) + " " + breakfastCost.get(i) + "' id = 'b" + i
					+ "'/>");
			out.write(breakfastType.get(i));
			out.write(", Costs: ");
			out.write(breakfastCost.get(i));
			out.write("$");
			out.write("<br />");
		}
		out.write("</fieldset>");
	%>

	<INPUT TYPE="BUTTON" VALUE="Choose" ONCLICK="sendToResevationInfoPage()">
			<script LANGUAGE="JavaScript">
				function sendToResevationInfoPage(){
										
					var roomType = document.getElementById("roomSpan");
					var selectedRoomType = roomType.options[roomType.selectedIndex].innerText;	
					
					var checkInMonth = document.getElementById("inMonth");
					var selectedCheckInMonth = checkInMonth.options[checkInMonth.selectedIndex].value;

					var checkInDay = document.getElementById("inDay");
					var selectedCheckInDay = checkInDay.options[checkInDay.selectedIndex].innerText;

					var checkInYear = document.getElementById("inYear");
					var selectedCheckInYear = checkInYear.options[checkInYear.selectedIndex].innerText;	

					var checkOutMonth = document.getElementById("outMonth");
					var selectedCheckOutMonth = checkOutMonth.options[checkOutMonth.selectedIndex].value;

					var checkOutDay = document.getElementById("outDay");
					var selectedCheckOutDay = checkOutDay.options[checkOutDay.selectedIndex].innerText;

					var checkOutYear = document.getElementById("outYear");
					var selectedCheckOutYear = checkOutYear.options[checkOutYear.selectedIndex].innerText;

					var serviceSize = '<%=serviceSize%>';
					var selectedServices ='';
					for(var i = 0; i< serviceSize; i++){
						var service = (document.getElementById(i));
							if(service.checked){
								selectedServices += service.value;
								selectedServices += ';';
							}
					}
										
					
					var breakfastSize = '<%=breakfastSize%>';
					var b = 'b';
					var selectedBreakfast ='';
					
					for(i = 0; i < breakfastSize; i++){
						var id = b+i;
						var breakfast = (document.getElementById(id));
							if(breakfast.value != '0'){
								selectedBreakfast += (breakfast.name + " " + breakfast.value);
								selectedBreakfast += ';';
							}
					}
					
					
					window.location = "http://localhost:8080/cs336Final/Reservation/giveReservationInformation.jsp?roomType="
						+ selectedRoomType + "&inDay=" + selectedCheckInDay + "&inMonth=" + selectedCheckInMonth +
						"&inYear=" + selectedCheckInYear + "&outDay=" + selectedCheckOutDay + "&outMonth=" + selectedCheckOutMonth + "&outYear=" + 
						selectedCheckOutYear + "&services=" + selectedServices + "&breakfast=" + selectedBreakfast;
					
					
				}
			</script>

</body>
</html>