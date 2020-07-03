<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <%@page import="java.sql.*,java.util.*"%>
  <% String med = request.getParameter("Text1");
  	 String quantity = request.getParameter("Text2");
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
  	 ResultSet resultSet = null;
  	 String pid = request.getParameter("Pid");
  	String ans="";
  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Prescribe Medicine</title>
</head>
<body bgcolor ="lightblue">
    <h1 align="center" class="auto-style3" style="color: #00FFFF; background-color: #000080;">Hospital Management System</h1>
    <p align="center">&nbsp;</p>
    <% 
    try{
		connection = DriverManager.getConnection(connectionUrl+database, userid, password);
		statement=connection.createStatement();
		String sql ="SELECT * FROM `med_mstr` WHERE Mname LIKE \'"+med+"\' AND Quantity >="+quantity+"";
		resultSet = statement.executeQuery(sql);
		//out.println(med+"  "+quantity);
		//out.println(resultSet.next());
		//out.println(pid);
		
		if(resultSet.next()==false){
			ans = "Sorry,the required medicine cannot be prescribed due to lack of stock!";
		}
		else{
			String mid = resultSet.getString("Mid");
			//out.println("Mid="+mid);
			ans = "Medicine succesfully prescribed to patient";
			String sql1="insert into med_issued(Pid,Mid,Quantity)values('"+pid+"','"+mid+"','"+quantity+"')";
			String sql2="UPDATE med_mstr SET Quantity = Quantity-"+quantity+" WHERE Mid="+mid+";";
			int i=statement.executeUpdate(sql1);
			i = statement.executeUpdate(sql2);
		}
    }
    catch(Exception e1){
    	e1.printStackTrace();
    }
     %>
	<h2 align="center"><%=ans %></h2>
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
                <form id="back" method="post" action="IssueMed.jsp">
                <input type="hidden" name="Pid" value ="<%=pid %>"/>
        <input id="Button1" class="auto-style4" style="font-family: Arial; font-size: x-large; color: #FFFFFF; background-color: #000000" type="submit" value="Back"  /></form>></td>
                <td class="auto-style6" align="center">
                    &nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
</body>
</html>