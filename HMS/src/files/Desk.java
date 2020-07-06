package files;
import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//Created by Prakhar. Completed on 30/6.
/**
 * Servlet implementation class Desk
 */
@WebServlet("/Desk")
public class Desk extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Desk() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Servlet#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		DBConnection dbcon = new DBConnection();
		Connection con = dbcon.getConnection();
		String spid = request.getParameter("spid");
		
		String go = request.getParameter("goto");

		String res = "";
		String sql = "select * from patients where pid ="+spid;
		
		
//		pstat=con.prepareStatement("select typeid from users where username=? and password=?");             
//      pstat.setString(1, username);
//      pstat.setString(2, password);
//      rs=pstat.executeQuery();
		
		try {
			PreparedStatement ps = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			
			ResultSet rs = ps.executeQuery();
			
			// System.out.println(rs.next()); returns true or false
			//System.out.println("before check: "+rs.isBeforeFirst());
			
			if (!rs.next()) {
				//System.out.println("0 rows returned");
				//System.out.println("sending redirect");
				response.sendRedirect("desk.jsp?smsg=No Patient found with ID="+ spid + "&go=" +go);
			}
			else {
				//System.out.println("exited if");
				//System.out.println("inside else "+rs.isBeforeFirst());
				rs.beforeFirst();
				//System.out.println("after: "+rs.isBeforeFirst());
				
			while (rs.next()) {
				String pname = rs.getString("pname");
				String page = rs.getString("page");
				String pdate = rs.getString("admitdate");
				String pbed = rs.getString("bedtype");
				String paddr = rs.getString("addr");
				String pcity = rs.getString("city");
				String pstate = rs.getString("state");
				
				String bedret;
				if (pbed.equalsIgnoreCase("General Ward"))
					bedret = "0";
				else if (pbed.equalsIgnoreCase("Semi-Sharing"))
					bedret = "1";
				else
					bedret = "2";
				res = "Success";

				String ret = "desk.jsp?smsg=" + res + "&pname=" + pname + "&page=" + page + "&padmit=" + pdate + "&pbed="
						+ bedret + "&paddr=" + paddr + "&pcity=" + pcity + "&pstate=" + pstate + "&spid=" + spid + "&go=" +go
						+ "&search=Patient found";
				//con.close();

				response.sendRedirect(ret);
				//System.out.println("from desk");
				//System.out.println(pbed +" " + bedret);
				//System.out.println(ret);
			}
			}
		} catch (SQLException e) {
			System.out.println("Error in doPost Desk class");
			e.printStackTrace();
		}
	}
}