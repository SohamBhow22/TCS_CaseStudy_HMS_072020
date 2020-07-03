<!--created by SB on 01072020-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="files.AddTestDiagDAO"%>
    <%@ page import="files.DiagnosticTest"%>
    <%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
	
	<script type="text/javascript">
		window.onLoad = function()
		{
			<% String pid = request.getParameter("pid")==null ? "0" : request.getParameter("pid"); 
				int p = Integer.parseInt(request.getParameter("pid")); 
				System.out.println(p+"qwert"); 
				AddTestDiagDAO tDao = new AddTestDiagDAO();
				ArrayList<DiagnosticTest> dlist = tDao.getDiagTests();
				int len = dlist.size();
				String tname[] = new String[len];
				int tid[] = new int[len];
				for(int i=0;i<len;i++)
				{
					tid[i] = dlist.get(i).getTid();
					tname[i] = dlist.get(i).getTname();
					System.out.println(dlist.get(i).getTname());
				}
			%>
		}
	</script>
	<head>
		<meta charset="ISO-8859-1">
		<title>Add Diagnostic Test</title>
	</head>

<!-- ############################################################################################### -->

	<% String msg = request.getParameter("msg")==null ? "" : request.getParameter("msg"); %>
	<% String name = request.getParameter("name")==null ? "" : request.getParameter("name"); %>
	<% String rate = request.getParameter("rate")==null ? "0" : request.getParameter("rate"); %>
	
	
	<body style="background-color:lightblue;text-align:center">
			<h1>ABC Hospital Management System</h1>
			<hr>
			
			<div>
				<form action="AddTest_Diag" method="post">
					  <label for="test">Choose a Diagnostic Test:</label>
					  <select name="diagtest" id="test">
					  <% for(int i=0;i<len;i++) { %>
					    <option value="<%=tid[i]%>"><%=tname[i]%></option>
					    <% } %>
					  </select>
					  <input type="hidden" name="pid" value="<%=pid %>">
					  <br><br>
					  <input type="submit" value="Add Test">
				</form>
				<br>
				<form action="AddTest_Diag" method="get">
					  <input type="submit" name="toHome" value="Back to Search Patient">
				</form>
			</div>
			
			<br>
			
			<%if(!msg.equals("")) {%>
			<div>
				<label><%=msg%></label>
				<br>
				<label>You added <%=name%>.</label>
				<br>
				<label>You can add another Test!</label>
			</div>
			
			<br>
			
			<div>
				<h4 align ="center">Rate for <%=name%> is Rs.<%=rate %></h4>
			</div>
			<%} %>
		
	</body>
</html>