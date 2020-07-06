package files;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//created by SB on 01072020

/**
 * Servlet implementation class AddTest_Diag
 */
@WebServlet("/AddTest_Diag")
public class AddTest_Diag extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddTest_Diag() {
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

		//response.getWriter().append("Served at: ").append(request.getContextPath());
		response.sendRedirect("searchpatient_diag.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//doGet(request, response);
		int tid = Integer.parseInt(request.getParameter("diagtest")); 
		int pid = Integer.parseInt(request.getParameter("pid")); 
		System.out.println(tid+"qwerty"+pid);
		AddTestDiagDAO tDao = new AddTestDiagDAO(pid,tid);
		DiagnosticTest dt = new DiagnosticTest();
		dt = tDao.addTest();
		String msg = "";
		String name = "";
		float rate = dt.getRate();
		if(dt != null)
		{
			msg = "Diagnostics added successfully!";
			name = dt.getTname();
			response.sendRedirect("adddiag.jsp?pid="+pid+"&msg="+msg+"&name="+name+"&rate="+rate);
			System.out.println(dt.getRate());
		}
	}

}
