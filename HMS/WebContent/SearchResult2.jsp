<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@page import="java.sql.*,java.util.*"%>
   
 <%
 String driver = "com.mysql.jdbc.Driver";
 String connectionUrl = "jdbc:mysql://localhost:3308/";
 String database = "xml_tcs";
 String userid = "root";
 String password = "";
 String pid = request.getParameter("patient_id");
 try {
 Class.forName(driver);
 } catch (ClassNotFoundException e) {
 e.printStackTrace();
 }
 Connection connection = null;
 Statement statement = null;
 ResultSet resultSet = null;
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Patient Information</title>
 <style type="text/css">
        .auto-style3 {
            height: 61px;
        }
        .auto-style4 {
            width: 70px;
            height: 37px;
        }
    </style>
    <script type="text/javascript">
    </script>
</head>
<body bgcolor ="light blue">
    <h1 align="center" class="auto-style3" style="color: #00FFFF; background-color: #000080;">Hospital Management System</h1>
    <h2 align ="center">Patient Info</h2>
    <div id="pat">
    	<%
    	    int i=0;
    		try{
    			connection = DriverManager.getConnection(connectionUrl+database, userid, password);
    			statement=connection.createStatement();
    			String sql ="select * from patient";
    			resultSet = statement.executeQuery(sql);
    			
    			while(resultSet.next()){
    				if(resultSet.getString(1).equals(pid)){i=1;break;}
    			}
    			if(i==0){
    				String ans = "Patient record not found!";
    			    out.println(ans);
    			}
    			else{
    	%>
    	<table border=1 bgcolor="white">
    		<tr bgcolor="brown" style="color:white">
    			<td>Patient ID</td>
    			<td>Patient Name</td>
    			<td>Age</td>
    			<td>Address</td>
    			<td>Date of Joining</td>
    			<td>Room Type</td>
    		</tr>
    		<tr>
    			<td><%=resultSet.getString(1) %></td>
    			<td><%=resultSet.getString(2) %></td>
    			<td><%=resultSet.getString(3) %></td>
    			<td><%=resultSet.getString(4) %></td>
    			<td><%=resultSet.getString(5) %></td>
    			<td><%=resultSet.getString(6) %></td>
    		</tr>
    	<%
    			}
    		}
    	    catch(Exception e1){
    	    	e1.printStackTrace();
    	    }
    	    finally{
    	    	out.println("Adios Amigo!!");
    	    }
    	%>
    	</table>
    </div>
    <h2 align ="center">Medicine Issued</h2>
    <div id ="med"></div>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
    <p>
        <input id="Button1" class="auto-style4" style="font-family: Arial; font-size: x-large; color: #FFFFFF; background-color: #000000" type="button" value="Back" onclick="history.back()" /></p>
    </body>
</html>



onkeydown="return event.keyCode !== 69"
onkeypress="preventNonNumericalInput(event)" required