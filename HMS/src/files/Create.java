package files;


import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Create
 */
@WebServlet("/Create")
public class Create extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Create() {
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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		DBConnection dbcon = new DBConnection();
		Connection con = dbcon.getConnection();
		
		String go = request.getParameter("goto");
		
		String res = "";		
		String sql = "";
		response.setContentType("text/html");
		
		System.out.println("from create "+go);
		//get data
		String pid = request.getParameter("pid");
		String pname = request.getParameter("pname");
		String page = request.getParameter("page");
		String pdate = request.getParameter("padmit");
		String pbed = request.getParameter("pbed");
		String paddr = request.getParameter("paddr");
		String pcity = request.getParameter("pcity");
		String pstate = request.getParameter("pstate");
		//String pstatus = request.getParameter("pstatus");
		
		sql = "insert into patients (ssn_id, pid, pname, page, admitdate, bedtype, addr, city, state, status) "
				+ "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		try {
			res="Success";
			PreparedStatement ps = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			
			ps.setString(1, pid);
			ps.setString(2, pid);
			ps.setString(3, pname);
			ps.setString(4, page);
			ps.setString(5, pdate);
			ps.setString(6, pbed);
			ps.setString(7, paddr);
			ps.setString(8, pcity);
			ps.setString(9, pstate);
			ps.setString(10, "Active");
			
			ps.executeUpdate();
			
			/*
			 * String pstat;
			 * 
			 * if(pstatus.equalsIgnoreCase("Active")) pstat = "0"; else pstat = "1";
			 * 
			 * 
			 * String bedret; if (pbed.equalsIgnoreCase("General Ward")) bedret = "0"; else
			 * if (pbed.equalsIgnoreCase("Semi-Sharing")) bedret = "1"; else bedret = "2";
			 */

			response.sendRedirect("desk.jsp?smsg=" + res +"&created=The record was successfully created");
		} catch (SQLException ex) {
			System.out.println("Error in doPost Create class");
			ex.printStackTrace();			
		}		
	}

}
