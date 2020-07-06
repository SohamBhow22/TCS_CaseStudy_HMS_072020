package files;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class PatientView {
	private String pid;
	private String pname;
	private String page;
	private String pdate;
	private String pbed;
	
	
	public PatientView() {
	}
	
	public PatientView(String pid, String pname, String page, String pdate, String pbed) {
		super();
		this.pid = pid;
		this.pname = pname;
		this.page = page;
		this.pdate = pdate;
		this.pbed = pbed;
	}



	public ArrayList<PatientView> getView() {
		
		DBConnection dbcon = new DBConnection();
		Connection con = dbcon.getConnection();
		
		//String res = "";		
		String sql = "select pid, pname, page, admitdate, bedtype from patients where status = ?";
		ArrayList<PatientView> pv = new ArrayList<PatientView>();
		
		try {
			PreparedStatement ps = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			ps.setString(1, "Active");
			
			ResultSet rs = ps.executeQuery();
			
			if(!rs.next()) {
				return pv;
			}
			else {				
				rs.beforeFirst();
				
				while(rs.next()) {
					String pid = rs.getString("pid");
					String pname = rs.getString("pname");
					String page = rs.getString("page");
					String pdate = rs.getString("admitdate");
					String pbed = rs.getString("bedtype");
					//String pstatus = rs.getString("status");
					//sSystem.out.println(status);
					
					pv.add(new PatientView(pid,pname,page,pdate,pbed));
				}
				//res = "Success";
				//System.out.println(res);
				return pv;				
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
			
		}
		return pv;
	}
	
	
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public String getPdate() {
		return pdate;
	}
	public void setPdate(String pdate) {
		this.pdate = pdate;
	}
	public String getPbed() {
		return pbed;
	}
	public void setPbed(String pbed) {
		this.pbed = pbed;
	}

}
