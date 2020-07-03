<%@page import="com.mysql.jdbc.Driver"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%

//Defining drivers and database connectiom paths
String driver = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String database = "hms_tcs";
String userid = "root";
String password = "prakhar3198#98";
try {
Class.forName(driver);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}
Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;// stores the result returned by SQL queries
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
 <style type="text/css">
        .auto-style1 {
            width: 99px;
        }
        .auto-style2 {
            width: 300px;
        }
        .auto-style3 {
            height: 61px;
        }
    </style>
</head>
<body bgcolor ="lightblue">
    <h1 align="center" class="auto-style3" style="color: #00FFFF; background-color: #000080;">Hospital Management System</h1>
    <p align="center">&nbsp;</p>
    <form id="form1" method="post" action="SearchResult.jsp" >
        <table id ="pid">
            <tr>
                <td class="auto-style2" align="right">Patient ID:</td>
                <td>
                    <input id="patient_id" class="auto-style1" type="text" name="patient_id" /></td>
                <td>
                    
                    <input id="Submit1" type="submit" value="Search" /></td>
            </tr>
        </table>
    </form>
    <div id="pat" align="center">
    <table border="1"  style="background-color:white; border:1px solid black; border-collapse:collapse">
    	<tr style="color:blue">
    		<td>Patient ID</td>
    		<td>Patient Name</td>
    		<td>Patient Age</td>
    		<td>Patient Address</td>
    		<td>Date of Joining</td>
    		<td>Room Type</td>
    	</tr>
   <%
try{
connection = DriverManager.getConnection(connectionUrl+database, userid, password);
statement=connection.createStatement();
String sql ="select * from patients"; //SQL query to retrieve data from the patients table
resultSet = statement.executeQuery(sql);
while(resultSet.next()){//Displaying output in the webpage as a table
%>
<tr>
<td><%=resultSet.getString(2) %></td>
<td><%=resultSet.getString(3) %></td>
<td><%=resultSet.getString(4) %></td>
<td><%=resultSet.getString(7) %></td>
<td><%=resultSet.getString(5) %></td>
<td><%=resultSet.getString(6) %></td>
</tr>
<%
}
connection.close();
} catch (Exception e) {
e.printStackTrace();
}
%>
</table>
</div>>
</body>
</html>