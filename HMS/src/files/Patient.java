package files;

import java.util.ArrayList;

//created by SB on 30062020
public class Patient {
	private int SSN_ID;
	private int pid;
	private String Pname;
	private int Page;
	private String AdmitDate;
	private String BedType;
	private String Addr;
	private String City;
	private String State;
	private String Status;
	private ArrayList<Integer> MedIds = new ArrayList<Integer>(); 
	private ArrayList<String> MedNames = new ArrayList<String>();
	private ArrayList<Integer> MedQty = new ArrayList<Integer>();
	private int MedFlag;
	private ArrayList<Integer> TestIds = new ArrayList<Integer>(); 
	private ArrayList<String> TestNames = new ArrayList<String>();
	private ArrayList<Integer> TestQty = new ArrayList<Integer>();
	private int TestFlag;
	
	public Patient(int sSN_ID, int pid, String pname, int page, String admitDate, String bedType, String addr,
			String city, String state, String status, ArrayList<Integer> medIds, ArrayList<String> medNames,
			ArrayList<Integer> medQty, int medFlag, ArrayList<Integer> testIds, ArrayList<String> testNames,
			ArrayList<Integer> testQty, int testFlag) {
		super();
		SSN_ID = sSN_ID;
		this.pid = pid;
		Pname = pname;
		Page = page;
		AdmitDate = admitDate;
		BedType = bedType;
		Addr = addr;
		City = city;
		State = state;
		Status = status;
		MedIds = medIds;
		MedNames = medNames;
		MedQty = medQty;
		MedFlag = medFlag;
		TestIds = testIds;
		TestNames = testNames;
		TestQty = testQty;
		TestFlag = testFlag;
	}



	public Patient() {
		super();
	}

	public int getSSN_ID() {
		return SSN_ID;
	}

	public void setSSN_ID(int sSN_ID) {
		SSN_ID = sSN_ID;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public String getPname() {
		return Pname;
	}

	public void setPname(String pname) {
		Pname = pname;
	}

	public int getPage() {
		return Page;
	}

	public void setPage(int page) {
		Page = page;
	}

	public String getAdmitDate() {
		return AdmitDate;
	}

	public void setAdmitDate(String admitDate) {
		AdmitDate = admitDate;
	}

	public String getBedType() {
		return BedType;
	}

	public void setBedType(String bedType) {
		BedType = bedType;
	}

	public String getAddr() {
		return Addr;
	}

	public void setAddr(String addr) {
		Addr = addr;
	}

	public String getCity() {
		return City;
	}

	public void setCity(String city) {
		City = city;
	}

	public String getState() {
		return State;
	}

	public void setState(String state) {
		State = state;
	}

	public String getStatus() {
		return Status;
	}

	public void setStatus(String status) {
		Status = status;
	}


	public ArrayList<Integer> getMedIds() {
		return MedIds;
	}


	public void setMedIds(ArrayList<Integer> medIds) {
		MedIds = medIds;
	}


	public ArrayList<String> getMedNames() {
		return MedNames;
	}


	public void setMedNames(ArrayList<String> medNames) {
		MedNames = medNames;
	}


	public ArrayList<Integer> getMedQty() {
		return MedQty;
	}


	public void setMedQty(ArrayList<Integer> medQty) {
		MedQty = medQty;
	}


	public int getMedFlag() {
		return MedFlag;
	}


	public void setMedFlag(int medFlag) {
		MedFlag = medFlag;
	}



	public ArrayList<Integer> getTestIds() {
		return TestIds;
	}



	public void setTestIds(ArrayList<Integer> testIds) {
		TestIds = testIds;
	}



	public ArrayList<String> getTestNames() {
		return TestNames;
	}



	public void setTestNames(ArrayList<String> testNames) {
		TestNames = testNames;
	}



	public ArrayList<Integer> getTestQty() {
		return TestQty;
	}



	public void setTestQty(ArrayList<Integer> testQty) {
		TestQty = testQty;
	}



	public int getTestFlag() {
		return TestFlag;
	}



	public void setTestFlag(int testFlag) {
		TestFlag = testFlag;
	}
	
}
