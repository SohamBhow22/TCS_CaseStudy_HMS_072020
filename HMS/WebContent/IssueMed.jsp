<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%
String driver = "com.mysql.cj.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String database = "hms_tcs";
String userid = "root";
String password = "prakhar3198#98";
String pid = request.getParameter("Pid");
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
<title>Insert title here</title>
<style type="text/css">
        .auto-style3 {
            height: 61px;
        }
        .auto-style4 {
            width: 70px;
            height: 37px;
        }
        .auto-style5 {
            width: 320px;
        }
        .auto-style6 {
            width: 322px;
        }
        </style>
</head>
<body bgcolor ="lightblue">
    <h1 align="center" class="auto-style3" style="color: #00FFFF; background-color: #000080;">Hospital Management System</h1>
    <h2 align ="center">Available Medicine</h2>
    <div id ="med" align="center">
    		  <table  border="1" style="background-color:white; border-collapse:collapse;">
    	<tr>
    		<th>Medicine ID</th>
    		<th>Medicine Name</th>
    		<th>Quantity</th>
    		<th>Rate</th>
    	</tr>
   <%
try{
connection = DriverManager.getConnection(connectionUrl+database, userid, password);
statement=connection.createStatement();
String sql ="select * from med_mstr";
resultSet = statement.executeQuery(sql);
while(resultSet.next()){
%>
<tr>
<td><%=resultSet.getString(1) %></td>
<td><%=resultSet.getString(2) %></td>
<td><%=resultSet.getString(3) %></td>
<td><%=resultSet.getString(4) %></td>
</tr>
<%
}
connection.close();
} catch (Exception e) {
e.printStackTrace();
}
%>
</table>
    </div>
    <p>
        <form id="med" method="post" action="Prescribe.jsp">
        <table style="width:100%;">
            <tr>
                
                <td align="right">Enter Medicine Name:</td>
                <td>
                    <input id="Text1" name="Text1" type="text" /></td>
            </tr>
            <tr>
                
                <td align="right">Enter Quantity</td>
                <td>
                    <input id="Text2" name="Text2" type="text" /></td>
            </tr>
           <tr>
                <td><input type="hidden" name="Pid" value="<%=pid%>"></td>
                <td align="right"></td>
                <td>
                    <input id="Submit1" type="submit" value="Add" style="font-family: 'Arial Black'; color: #FFFFFF; background-color: #000000"></td>
            </tr>
        </table>
       </form>
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
        &nbsp;</p>
        <table style="width:100%;">
            <tr>
                <td class="auto-style5">
                <form method="post" action="SearchResult.jsp">
                 <input type="hidden" name="patient_id" value ="<%=pid %>"/>
       <input id="Button1" class="auto-style4" style="font-family: Arial; font-size: x-large; color: #FFFFFF; background-color: #000000" type="submit" value="Back"/></form>
       </td>
                <td class="auto-style6" align="center">
                	
                 </td>
               		
                <td>&nbsp;</td>
            </tr>
        </table>
    </body>
</html>