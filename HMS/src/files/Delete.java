package files;


import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Delete
 */
@WebServlet("/Delete")
public class Delete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Delete() {
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
		
		/*
		 * String pname = request.getParameter("pname"); String page =
		 * request.getParameter("page"); String pdate = request.getParameter("padmit");
		 * String pbed = request.getParameter("pbed"); String paddr =
		 * request.getParameter("paddr"); String pcity = request.getParameter("pcity");
		 * String pstate = request.getParameter("pstate");
		 */
		String spid = request.getParameter("spid");
		
		/*
		 * String bedret; if (pbed.equalsIgnoreCase("General Ward")) bedret = "0"; else
		 * if (pbed.equalsIgnoreCase("Semi-Sharing")) bedret = "1"; else bedret = "2";
		 */
		
		String res = "";
		String sql = "delete from patients where pid ="+spid;
		response.setContentType("text/html");
		
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			
			
			int rows = -1;
			rows = ps.executeUpdate();
			//System.out.println(rows+" rows deleted");
			
			if(rows==-1) {
				response.sendRedirect("desk.jsp?smsg=No Patient found with ID="+spid);
			} else {
				res = "Success";
				//String ret = "desk.jsp?smsg=" + res + "&pname=" + pname + "&page=" + page + "&padmit=" + pdate + "&pbed="
					//	+ bedret + "&paddr=" + paddr + "&pcity=" + pcity + "&pstate=" + pstate + "&spid=" + spid  + "&go=" +go;
				
				response.sendRedirect("desk.jsp?smsg=" + res +"&deleted=Patient deletion initiated successfully&go=d");
			}
			
		} catch (SQLException e) {
			System.out.println("Error in doPost Delete class");
			e.printStackTrace();
		} 
	}

}
