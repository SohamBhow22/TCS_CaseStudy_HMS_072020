package files;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//created by SB on 28062020

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
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
		//doGet(request, response);
		String userid = request.getParameter("user");
		String password = request.getParameter("password");
		LoginDAO lDao = new LoginDAO(userid, password);
		/*String result = lDao.checkPassword();
		System.out.println(result);
		//response.getWriter().print(result);*/
		int flag = lDao.checkPassword();
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String loginCheckString = "";
		if(flag == 0)
		{
			loginCheckString = "Login Unsucessful!! Please check your credentials!"; 
			response.sendRedirect("login.jsp?msg="+loginCheckString);  
		}
		else if(flag == 1)
		{
			response.sendRedirect("PlaceholderFile.html");  
		}
		out.close();

	}

}
