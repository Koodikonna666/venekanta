package model;

public class Vene {
	private int tunnus, hinta;
	private double pituus, leveys;
	private String nimi, merkkimalli;

	public Vene(int tunnus, String nimi, String merkkimalli, double pituus, double leveys, int hinta ) {
		super();
		this.tunnus = tunnus;
		this.nimi = nimi;
		this.merkkimalli = merkkimalli;
		this.pituus = pituus;
		this.leveys = leveys;
		this.hinta = hinta;
	}
	
	public Vene() {
		super();
	}

	public int getTunnus() {
		return tunnus;
	}

	public void setTunnus(int tunnus) {
		this.tunnus = tunnus;
	}

	public int getHinta() {
		return hinta;
	}

	public void setHinta(int hinta) {
		this.hinta = hinta;
	}

	public double getPituus() {
		return pituus;
	}

	public void setPituus(double pituus) {
		this.pituus = pituus;
	}

	public double getLeveys() {
		return leveys;
	}

	public void setLeveys(double leveys) {
		this.leveys = leveys;
	}

	public String getNimi() {
		return nimi;
	}

	public void setNimi(String nimi) {
		this.nimi = nimi;
	}

	public String getMerkkimalli() {
		return merkkimalli;
	}

	public void setMerkkimalli(String merkkimalli) {
		this.merkkimalli = merkkimalli;
	}

	
	@Override
	public String toString() {
		return "Vene [tunnus=" + tunnus + ", hinta=" + hinta + ", pituus=" + pituus + ", leveys=" + leveys + ", nimi="
				+ nimi + ", merkkimalli=" + merkkimalli + "]";
	}

}
