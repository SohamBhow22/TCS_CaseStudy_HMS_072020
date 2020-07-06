package files;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Bill
 */
@WebServlet("/Bill")
public class Bill extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Bill() {
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
		String spid = request.getParameter("spid");
		
		String go = request.getParameter("goto");

		String res = "";
		String sql = "select pname, page, addr, admitdate, bedtype from patients where pid ="+spid;
		
		//String getdate = "select current_date() from dual";
		
		try {
			PreparedStatement ps = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			//PreparedStatement gdate = con.prepareStatement(getdate);
			
			ResultSet rs = ps.executeQuery();
			//ResultSet date = gdate.executeQuery();
			
			if (!rs.next()) {
				//System.out.println("0 rows returned");
				//System.out.println("sending redirect");
				response.sendRedirect("desk.jsp?smsg=No Patient found with ID="+ spid + "&go=" +go);
			}
			else {
				res="Success";
				rs.beforeFirst();
				
				Date dt = new Date();
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				
				while(rs.next()) {
					String pname = rs.getString("pname");
					String page = rs.getString("page");
					String paddr = rs.getString("addr");
					
					String pdate = rs.getString("admitdate");
					
					String disc = formatter.format(dt);		
					String pbed = rs.getString("bedtype");
					
					LocalDate dateBefore = LocalDate.parse(pdate);
					LocalDate dateAfter = LocalDate.parse(disc);
						
					//calculating number of days in between
					long days = ChronoUnit.DAYS.between(dateBefore, dateAfter);
					
					//System.out.println(disc);
					
					String bedret;
					if (pbed.equalsIgnoreCase("General Ward"))
						bedret = "0";
					else if (pbed.equalsIgnoreCase("Semi-Sharing"))
						bedret = "1";
					else
						bedret = "2";
					
					String ret = "desk.jsp?smsg=" + res + "&pname=" + pname + "&page=" + page + "&pbed=" + bedret + 
								 "&padmit=" + pdate + "&paddr=" + paddr + "&spid=" + spid + "&disc=" + disc + "&days=" + days +"&go=" +go;
					 
					 
					 //System.out.println(rows + " " + getests.getString("sum(t.quantity)"));
					 
					//System.out.println(ret);
					
					response.sendRedirect(ret);
				}
				
			}
		} catch (SQLException e) {
			System.out.println("Error in doPost Bill class");
			e.printStackTrace();
		}
	}
}
