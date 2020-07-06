package files;
import java.sql.*;

public class DBConnection {
	String url = "jdbc:mysql://localhost:3306/hms_tcs";
	String user = "root";
	String pass = "prakhar3198#98";

	public void loadDriver() {
		try {
			DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());

		} catch (Exception e) {
			System.err.println("Error in loadDriver");
			e.printStackTrace();
		}
	}

	public Connection getConnection() {
		loadDriver();
		Connection con = null;
		try {
			con = DriverManager.getConnection(url, user, pass);
		} catch (SQLException ex) {
			System.out.println("Error in getConnection");
			ex.printStackTrace();
		}
		return con;
	}
}
