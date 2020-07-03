<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <!--created by SB on 28062020-->
<!DOCTYPE html>
<html>
	
	<script type="text/javascript">
		function CheckPassword(inputtxt) 
		{ 
			var passw =  /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])\w{10,15}$/;
			if(inputtxt.value.match(passw)) 
			{ 
				alert('Correct, try another...')
				return true;
			}
			else
			{ 
				alert('Wrong...!')
				return false;
			}
		}
	</script>
	
	<head>
		<meta charset="ISO-8859-1">
		<title>ABC Hospital Management System</title>
	</head>
	
	<% String msg = request.getParameter("msg")==null ? "" : request.getParameter("msg"); %>
	
	<body style="background-color:lightblue;text-align:center">
		<h1>ABC Hospital Management System</h1>
		<hr>
		<form name="form1" action="Login" method="post">
		<div>
			<h4>Login</h4>
			<table style="border:3px solid black;margin-left:auto;margin-right:auto;">
				<tr>
					<td>User</td>
					<td><input type="text" name="user" minlength="8" maxlength="15" required></td>
				</tr>
				<tr>
					<td>Password</td>
					<td><input type="password" name="password" minlength="10" maxlength="15" 
						onsubmit="CheckPassword(document.form1.password)" 
						pattern="^[a-zA-Z0-9]{10,15}$" title="Only Alphanumeric characters allowed"
						required></td>
				</tr>
				<tr>
					<td></td>
					<td><input type="submit" name="login" value="Login"></td>
				</tr>
			</table>
		</div>
		<%if(!msg.equals("")) {%>
			<div>
				<p style="color:red;text-align:center"><%=msg %></p>
			</div>
		<%} %>
		</form>
	</body>
	
</html>