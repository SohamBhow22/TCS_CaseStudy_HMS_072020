package files;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//created by SB on 29062020

/**
 * Servlet implementation class SearchPatient_Diag
 */
@WebServlet("/SearchPatient_Diag")
public class SearchPatient_Diag extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchPatient_Diag() {
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
		int pid = Integer.parseInt(request.getParameter("pid2"));
		System.out.println(pid);
		response.sendRedirect("adddiag.jsp?pid="+pid);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//doGet(request, response);
		System.out.println("Sucesss!");
		int pid = Integer.parseInt(request.getParameter("pid")); 
		System.out.println(pid);
		SearchPatientDiagDAO spdDao = new SearchPatientDiagDAO(pid);
		Patient p = spdDao.fetchPatient();
		String dataFetchCheckString = "";
		String testConductedCheckString = "";
		if(p == null)
		{
			dataFetchCheckString = "No data with Patient ID =" + pid + " found!";
			testConductedCheckString = "No such Patient admitted!"; 
			response.sendRedirect("searchpatient_diag.jsp?msg1="+dataFetchCheckString+"&msg2="+testConductedCheckString);  
		}
		else
		{
			int id = p.getPid();
			String pname = p.getPname();
			int age = p.getPage();
		    String admDt = p.getAdmitDate();
		    String bedtyp = p.getBedType();
		    String addr = p.getAddr();
		    String city = p.getCity();
		    String state = p.getState();
		    String status = p.getStatus();
		    
		    String data = "";
			//System.out.println(p.getSSN_ID());
		    int len = p.getTestIds().size();
			if(p.getTestFlag()==0)
			{
				testConductedCheckString = "No diagnostic test conducted for Patient ID = " + pid + "!";
				data = "pid="+id+"&pname="+pname+"&page="+age+
	    				"&adt="+admDt+"&bt="+bedtyp+"&add="+addr+
	    				"&city="+city+"&state="+state+"&status="+status+
	    				"&msg2="+testConductedCheckString;
			}
			else
			{
			    String test = "";
			    for(int i=0;i<len;i++)
			    {
			    	test = test + "&tid" + (i+1) + "=" + p.getTestIds().get(i) +
			    			 "&tname" + (i+1) + "=" + p.getTestNames().get(i) + 
			    			 "&tqty" + (i+1) + "=" + p.getTestQty().get(i);
			    }
			    System.out.println(test);
				
				data = "pid="+id+"&pname="+pname+"&page="+age+
	    				"&adt="+admDt+"&bt="+bedtyp+"&add="+addr+
	    				"&city="+city+"&state="+state+"&status="+status+
	    				test+"&len="+len;
			}
			System.out.println(data);
			response.sendRedirect("searchpatient_diag.jsp?"+data);  
		}
	}

}
