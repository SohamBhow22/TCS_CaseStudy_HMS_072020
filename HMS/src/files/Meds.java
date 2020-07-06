package files;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Meds {	
	private String mid;
	private String mname;
	private float mquan;
	private float mrate;
	
	
	public Meds() {
		
	}
	
	public Meds(String mid, String mname, float mquan, float mrate) {
		super();
		this.mid = mid;
		this.mname = mname;
		this.mquan = mquan;
		this.mrate = mrate;
	}
	
	public ArrayList<Meds> getMeds(String spid){
		
		DBConnection dbcon = new DBConnection();
		Connection con = dbcon.getConnection();
		
		ArrayList<Meds> meds = new ArrayList<Meds>();
		
		String get = "select i.mid, sum(i.quantity), m.rate, m.mname from med_issued i inner join med_mstr m on i.mid = m.mid where i.pid=? group by i.mid";
		
		try {
			PreparedStatement getps = con.prepareStatement(get, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			getps.setString(1, spid);
			
			ResultSet getmeds= getps.executeQuery();
			
			if (!getmeds.next()) {
				System.out.println("fail" + " from Meds");
				return meds;
			}
			else {
				//System.out.println(rows);
				getmeds.beforeFirst();
				
				while(getmeds.next()) {
					String mid = getmeds.getString("i.mid");
					//System.out.println(mid);
					
					String mname = getmeds.getString("m.mname");
					//System.out.println(mname);
					
					float mquan = Float.parseFloat(getmeds.getString("sum(i.quantity)"));
					//System.out.println(mquan);
					
					float mrate = Float.parseFloat(getmeds.getString("m.rate"));
					//System.out.println(mrate);
					
					meds.add(new Meds(mid,mname,mquan,mrate));
				}
			}
			
		} catch(SQLException ex) {
			ex.printStackTrace();
		}
		return meds; 
	}

	
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public float getMquan() {
		return mquan;
	}
	public void setMquan(float mquan) {
		this.mquan = mquan;
	}
	public float getMrate() {
		return mrate;
	}
	public void setMrate(float mrate) {
		this.mrate = mrate;
	}

}
