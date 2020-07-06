package files;

public class DiagnosticTest {
	
	private int Tid;
	private String Tname;
	private Float rate;
	
	public DiagnosticTest() {
		super();
	}
	public DiagnosticTest(int tid, String tname, Float rate) {
		super();
		Tid = tid;
		Tname = tname;
		this.rate = rate;
	}
	public int getTid() {
		return Tid;
	}
	public void setTid(int tid) {
		Tid = tid;
	}
	public String getTname() {
		return Tname;
	}
	public void setTname(String tname) {
		Tname = tname;
	}
	public Float getRate() {
		return rate;
	}
	public void setRate(Float rate) {
		this.rate = rate;
	}
	
	

}
