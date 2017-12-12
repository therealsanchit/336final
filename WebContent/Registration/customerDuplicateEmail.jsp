<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

Email used to register already exists. Please log in here: 
<br>
<form method = "get" action = "../Login/customerLogin.jsp">
		<table>
			<tr>
				<td> Email Address </td> <td><input type = "text" name="customerEmail"></td>
			</tr>		
			
			<tr>
				<td> Password </td> <td><input type = "text" name="customerPassword"></td>
			</tr>
		
		</table>
			<br>
			<input type="submit" value="Login">
	</form>
	
<br>

Or Register again with a different email:

<br>	

	<form method = "get" action = "../Registration/customerRegister.jsp">
		<input type = "submit" value="Register">
	</form>
	

</body>
</html>