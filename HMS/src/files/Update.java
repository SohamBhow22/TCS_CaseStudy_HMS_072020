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
 * Servlet implementation class Update
 */
@WebServlet("/Update")
public class Update extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Update() {
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
		response.setContentType("text/html");
		
		//get data
		String pname = request.getParameter("pname");
		String page = request.getParameter("page");
		String pdate = request.getParameter("padmit");
		String pbed = request.getParameter("pbed");
		
		//System.out.println("from update");
		
		String paddr = request.getParameter("paddr");
		String pcity = request.getParameter("pcity");
		String pstate = request.getParameter("pstate");
		String pid = request.getParameter("spid");
		
		String sql = "update patients set pname=?, page=?, admitdate=?, bedtype=?, addr=?, city=?, state=? where pid = ?";
		
		try {
			PreparedStatement ps = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			
			ps.setString(1, pname);
			ps.setString(2, page);
			ps.setString(3, pdate);
			
			ps.setString(4, pbed);
			//System.out.println(pbed);
			
			ps.setString(5, paddr);
			ps.setString(6, pcity);
			ps.setString(7, pstate);
			ps.setString(8, pid);
			
			ps.executeUpdate();
			res="Success";

			// System.out.println(rs.next()); returns true or false
			//System.out.println("before check: "+rs.isBeforeFirst());
			//System.out.println("exited if");
			//System.out.println("inside else "+rs.isBeforeFirst());
			//System.out.println("after: "+rs.isBeforeFirst());
			
			String bedret;
			if (pbed.equalsIgnoreCase("General Ward"))
				bedret = "0";
			else if (pbed.equalsIgnoreCase("Semi-Sharing"))
				bedret = "1";
			else
				bedret = "2";
			
			String ret = "desk.jsp?smsg=" + res + "&pname=" + pname + "&page=" + page + "&padmit=" + pdate + "&pbed="
					+ bedret + "&paddr=" + paddr + "&pcity=" + pcity + "&pstate=" + pstate + "&spid=" + pid  + "&go=" +go;
			
			//System.out.println(res+" update");
			response.sendRedirect(ret+"&updated=Patient update initiated successfully");
		} catch (SQLException e) {
			System.out.println("Error in doPost Update class");
			e.printStackTrace();
		}
	}

}
