<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

Please choose what you want to do:

<br>
<form method = "get" action = "../Reviews/reviewType.jsp">
		<table>
			<tr>
				<td> Review </td> <td><input type = "submit"></td>
			</tr>		
		</table>
	</form>

<form method = "get" action = "../Reservation/reservationHome.jsp">
		<table>
			<tr>
				<td> Reservation </td> <td><input type = "submit" ></td>
			</tr>		
		</table>
	</form>
	
<br>


</body>
</html>