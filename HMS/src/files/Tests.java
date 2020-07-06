package files;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Tests {
	private String tid;
	private String tname;
	private float tquan;
	private float trate;
	
	
	public Tests() {		
	}


	public Tests(String tid, String tname, float tquan, float trate) {
		super();
		this.tid = tid;
		this.tname = tname;
		this.tquan = tquan;
		this.trate = trate;
	}


	public ArrayList<Tests> getTests(String spid){
		
		DBConnection dbcon = new DBConnection();
		Connection con = dbcon.getConnection();
		
		ArrayList<Tests> tests = new ArrayList<Tests>();
		
		String get = "select t.tid, sum(t.quantity), m.rate, m.tname from test_con t inner join test_mstr m on t.tid = m.tid where t.pid=? group by t.tid";
		
		try {
			PreparedStatement getps = con.prepareStatement(get, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			getps.setString(1, spid);
			
			ResultSet getests = getps.executeQuery();
			

			if (!getests.next()) {
				System.out.println("fail" + " from Tests");
				return tests;
			}
			else {
				//System.out.println(rows);
				getests.beforeFirst();
				
				while(getests.next()) {
					String tid = getests.getString("t.tid");
					//System.out.println(tid);
					
					String tname = getests.getString("m.tname");
					//System.out.println(tname);
					
					float tquan = Float.parseFloat(getests.getString("sum(t.quantity)"));
					//System.out.println(tquan);
					
					float trate = Float.parseFloat(getests.getString("m.rate"));
					//System.out.println(trate);
					
					tests.add(new Tests(tid,tname,tquan,trate));
				}
			}
		} catch(SQLException ex) {
			ex.printStackTrace();
		}
		return tests; 
	}


	public String getTid() {
		return tid;
	}


	public void setTid(String tid) {
		this.tid = tid;
	}


	public String getTname() {
		return tname;
	}


	public void setTname(String tname) {
		this.tname = tname;
	}


	public float getTquan() {
		return tquan;
	}


	public void setTquan(float tquan) {
		this.tquan = tquan;
	}


	public float getTrate() {
		return trate;
	}


	public void setTrate(float trate) {
		this.trate = trate;
	}

}
