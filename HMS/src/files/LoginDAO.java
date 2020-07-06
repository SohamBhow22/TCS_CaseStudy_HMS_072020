package files;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

//created by SB on 28062020

public class LoginDAO {
	
	private String userid;
	private String password;
	
	public LoginDAO() {
		super();
	}
	
	public LoginDAO(String userid, String password) {
		super();
		this.userid = userid;
		this.password = password;
	}


	public int checkPassword()
	{
		DBConnection dbcon = new DBConnection();
		Connection con = dbcon.getConnection();
		String result = "";
		String sql = "Select * from userstore";
		int flag = 0;
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next())
			{
				/*System.out.print(rs.getString(1));
				System.out.print(rs.getString(2));
				System.out.print(rs.getTimestamp(3));
				System.out.println();*/
				if(this.getUserid().equals(rs.getString(1)) && this.getPassword().equals(rs.getString(2)) )
				{
					//System.out.println("you can log in");
					result = "Login Successful!";
					flag = 1;
					break;
				}
			}
			if(flag == 0)
				result = "Login Unsucessful!! Please check your credentials!";
			
			//System.out.println(flag);	
		} catch (SQLException e) {
			System.out.println("Error in checkPassword function in LoginDAO class");
			result = "Error from Program Side!!!";
			e.printStackTrace();
		}  
		/*try {
			PreparedStatement ps = con.prepareCall(sql);
			ps.setString(1, getUserid());
			ps.setString(2, getPassword());
			ps.executeUpdate();
		}catch (SQLException e) {
			System.out.println("Error in Insert function in LoginDAO class");
			result = "data not entered";
			e.printStackTrace();
		}*/
		System.out.println(result);
		return flag;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}
