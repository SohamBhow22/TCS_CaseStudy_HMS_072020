package files;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

//created by SB on 01072020

public class AddTestDiagDAO {
	
	private int pid;
	private int tid;

	public AddTestDiagDAO() {
		super();
	}
	
	public AddTestDiagDAO(int pid, int tid) {
		super();
		this.pid = pid;
		this.tid = tid;
	}

	public ArrayList<DiagnosticTest> getDiagTests()
	{
		ArrayList<DiagnosticTest> testlist = new ArrayList<DiagnosticTest>();
		DBConnection dbcon = new DBConnection();
		Connection con = dbcon.getConnection();
		String result = "";
		
		//Fetching diagnostic tests details here --------------------------------------------------------
		String sql = "SELECT * FROM `test_mstr` ORDER BY Tname ASC";
		try {
			PreparedStatement ps = con.prepareCall(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			ResultSet rs = ps.executeQuery();
			
			result = "Diagnostic Test details found!"; 
			while(rs.next())
			{
				//System.out.println(rs.getString(1));
				int tid = rs.getInt(1);
				String tname = rs.getString(2);
				float rate = rs.getFloat(3);
				DiagnosticTest dt =  new DiagnosticTest(tid,tname,rate);
				testlist.add(dt);
			}
		} catch (SQLException e) {
			System.out.println("Error in getDiagTests function in AddTestDiagDao class");
			result = "Error while fetching Diagnostic Tests!!!";
			e.printStackTrace();
		}
		System.out.println(result);
		return testlist;
	}

	
	public DiagnosticTest addTest()
	{
		DBConnection dbcon = new DBConnection();
		Connection con = dbcon.getConnection();
		DiagnosticTest dt = new DiagnosticTest();
		String result = "";
		int flag = 0;
		
		//Adding diagnostic tests details here --------------------------------------------------------
		String sql = "INSERT INTO `test_con` (`Pid`, `Tid`, `Quantity`) "+
					"VALUES (?, ?, ?);";
		try {
			PreparedStatement ps = con.prepareCall(sql,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			ps.setInt(1, this.getPid());
			ps.setInt(2, this.getTid());
			ps.setInt(3, 1);
			flag = ps.executeUpdate();
			result = "Diagnostic Test details added!";
			dt = this.getTestDets(this.getTid());
			
		} catch (SQLException e) {
			System.out.println("Error in addTest function in AddTestDiagDao class");
			result = "Error while adding Diagnostic Tests!!!";
			e.printStackTrace();
		}
		System.out.print(result);
		System.out.println(flag);	
		return dt;
	}
	
	public DiagnosticTest getTestDets(int testid)
	{
		DBConnection dbcon = new DBConnection();
		Connection con = dbcon.getConnection();
		DiagnosticTest dt = new DiagnosticTest();
		String result = "";
		
		//Fetching particular tests details here --------------------------------------------------------
		String sql = "SELECT * FROM `test_mstr` where tid = ?";
		
		try {
			PreparedStatement ps = con.prepareCall(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			ps.setInt(1, testid);
			ResultSet rs = ps.executeQuery();
			result = "Particular test deets found!";
			
			while(rs.next())
			{
				int tid = rs.getInt(1);
				String tname = rs.getString(2);
				float rate = rs.getFloat(3);
				System.out.println(tid+tname+rate);
				dt =  new DiagnosticTest(tid,tname,rate);
			}
			
			
		} catch (SQLException e) {
			System.out.println("Error in getTestDets function in AddTestDiagDao class");
			result = "Error while getting Test details!!!";
			e.printStackTrace();
		}
		System.out.print(result);
		
		return dt;
	}
	
	
	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public int getTid() {
		return tid;
	}

	public void setTid(int tid) {
		this.tid = tid;
	}
	

}
