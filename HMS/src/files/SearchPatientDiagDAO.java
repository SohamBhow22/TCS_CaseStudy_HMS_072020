package files;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

//created by SB on 29062020
public class SearchPatientDiagDAO {

	private int Pid;

	public SearchPatientDiagDAO() {
		super();
	}

	public SearchPatientDiagDAO(int pid) {
		super();
		Pid = pid;
	}
	
	public Patient fetchPatient()
	{
		DBConnection dbcon = new DBConnection();
		Connection con = dbcon.getConnection();
		String result = "";
		
		//Fetching patient details here --------------------------------------------------------
		String sql = "Select * from patients where Pid = ? and Status = \"Active\"";
		Patient p = new Patient();
		try {
			PreparedStatement ps = con.prepareCall(sql,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			ps.setInt(1, this.getPid());
			ResultSet rs = ps.executeQuery();
			
			if(!rs.next())
			{
				result = "No data with Patient ID=" + this.getPid() + "found!"; 
				return p = null;
			}
			else
			{
				result = "Patient details found!"; 
				p.setSSN_ID(rs.getInt(1));
				p.setPid(rs.getInt(2));
				p.setPname(rs.getString(3));
				p.setPage(rs.getInt(4));
				p.setAdmitDate(rs.getDate(5).toString());
				p.setBedType(rs.getString(6));
				p.setAddr(rs.getString(7));
				p.setCity(rs.getString(8));
				p.setState(rs.getString(9));
				p.setStatus(rs.getString(10));
				System.out.println(p.getPid()+" "+p.getPname()+" "+p.getStatus());
			}
			
		}catch (SQLException e) {
			System.out.println("Error in fetchPatient function in SearchPatientDiagDao class");
			result = "Error while fetching Patient Detail!!!";
			e.printStackTrace();
		}
		System.out.println(result);
		Patient pt = fetchMeds(p);
		System.out.println(p.getPid()+ " " + p.getTestIds());
		return pt;
	}
	
	public Patient fetchMeds(Patient p)
	{
		DBConnection dbcon = new DBConnection();
		Connection con = dbcon.getConnection();
		String result = "";
		
		//Fetching patient test details here --------------------------------------------------------
		String sql = "SELECT p.Pid, i.Tid, m.Tname, sum(i.Quantity)\r\n" + 
				"FROM test_con i INNER JOIN patients p INNER JOIN test_mstr m\r\n" + 
				"on i.Pid=p.Pid AND i.Tid=m.Tid\r\n" + 
				"WHERE p.Status=\"Active\" AND p.pid = ? " + 
				"GROUP BY p.Pid,m.Tid";
		System.out.println(sql);
		PreparedStatement ps;
		try {
			ps = con.prepareCall(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			ps.setInt(1, this.getPid());
			ResultSet rs = ps.executeQuery();
			if(!rs.next())
			{
				result = "No test conducted for Patient ID = " + this.getPid() + "!"; 
				p.setTestFlag(0);
			}
			else
			{
				result = "Tests found!";
				p.setTestFlag(1);
				ArrayList<Integer> tIds = new ArrayList<Integer>(); 
				ArrayList<String> tNames = new ArrayList<String>(); 
				ArrayList<Integer> tQty = new ArrayList<Integer>(); 
				rs.beforeFirst();
				while(rs.next()) 
				{
					tIds.add(rs.getInt(2));
					tNames.add(rs.getString(3));
					tQty.add(rs.getInt(4));
				}
				p.setTestIds(tIds);
				p.setTestNames(tNames);
				p.setTestQty(tQty);
				System.out.println(p.getTestIds()+""+p.getTestNames()+""+p.getTestQty());
			}
			
			
		} catch (SQLException e) {
			System.out.println("Error in fetchMeds function in SearchPatientDiagDao class");
			result = "Error while fetching Meds!!!";
			e.printStackTrace();
		}
		System.out.println(result);
		System.out.println(p.getPid());
		return p;
	}
	
	

	public int getPid() {
		return Pid;
	}

	public void setPid(int pid) {
		Pid = pid;
	}
	
}
