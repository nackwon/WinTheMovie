package kr.co.winthemovie.vo;

public class TheaterVo {

	private int theaterno;
	private int brandno;
	private String theatername;
	private String theateraddress;
	private String theaterxgps;
	private String theaterygps;

	public int getTheaterno() {
		return theaterno;
	}

	public void setTheaterno(int theaterno) {
		this.theaterno = theaterno;
	}

	public int getBrandno() {
		return brandno;
	}

	public void setBrandno(int brandno) {
		this.brandno = brandno;
	}

	public String getTheatername() {
		return theatername;
	}

	public void setTheatername(String theatername) {
		this.theatername = theatername;
	}

	public String getTheateraddress() {
		return theateraddress;
	}

	public void setTheateraddress(String theateraddress) {
		this.theateraddress = theateraddress;
	}

	public String getTheaterxgps() {
		return theaterxgps;
	}

	public void setTheaterxgps(String theaterxgps) {
		this.theaterxgps = theaterxgps;
	}

	public String getTheaterygps() {
		return theaterygps;
	}

	public void setTheaterygps(String theaterygps) {
		this.theaterygps = theaterygps;
	}

	@Override
	public String toString() {
		return "TheaterVo [theaterno=" + theaterno + ", brandno=" + brandno + ", theatername=" + theatername
				+ ", theateraddress=" + theateraddress + ", theaterxgps=" + theaterxgps + ", theaterygps=" + theaterygps
				+ "]";
	}
}
