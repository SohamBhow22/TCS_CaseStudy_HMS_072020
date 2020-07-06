package files;


import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class View
 */
@WebServlet("/View")
public class View extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public View() {
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
		
		PatientView p = new PatientView();
		ArrayList<PatientView> pv = new ArrayList<PatientView>();
		
		String go = request.getParameter("goto");
		
		pv = p.getView();
		
		if(pv.size() == 0) {
			response.sendRedirect("desk.jsp?smsg=No records found!" + "&go=" +go);
		}
		else {
			String res = "Success";
			response.sendRedirect("desk.jsp?smsg=" + res + "&go=" + go);			
		}
		
		
		/*
		 * DBConnection dbcon = new DBConnection(); Connection con =
		 * dbcon.getConnection();
		 * 
		 * String go = request.getParameter("goto");
		 * 
		 * String res = ""; String sql =
		 * "select pid, pname, page, admitdate, bedtype from patients";
		 * 
		 * try { PreparedStatement ps = con.prepareStatement(sql,
		 * ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		 * 
		 * ResultSet rs = ps.executeQuery();
		 * 
		 * if(!rs.next()) { response.sendRedirect("desk.jsp?smsg=No records found"); }
		 * else { ArrayList<String> prec = new ArrayList<String>();
		 * 
		 * rs.beforeFirst();
		 * 
		 * while(rs.next()) { String pid = rs.getString("pid"); String pname =
		 * rs.getString("pname"); String page = rs.getString("page"); String pdate =
		 * rs.getString("admitdate"); String pbed = rs.getString("bedtype");
		 * 
		 * prec.add(pid); prec.add(pname); prec.add(page); prec.add(pdate);
		 * prec.add(pbed); } res = "Success";
		 * 
		 * System.out.println(prec); request.setAttribute("prec", prec);
		 * response.sendRedirect("desk.jsp?smsg=" + res + "&go=" + go); } } catch
		 * (SQLException ex) { ex.printStackTrace();
		 * 
		 * }
		 */
	}

}
