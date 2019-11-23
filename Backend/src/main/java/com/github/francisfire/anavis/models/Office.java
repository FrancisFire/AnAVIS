package com.github.francisfire.anavis.models;


import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class Office {

	private String name;
	private Set<Date> donationTimeTables;

	public Office() {
	}
	
	/**
	 * 
	 * @param nome
	 * @param donatori
	 */
	public Office(String name) {
		this.name = name;
		this.donationTimeTables = new HashSet<>();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Set<Date> getDonationTimeTables() {
		return donationTimeTables;
	}

	public void setDonationTimeTables(Set<Date> donationTimeTables) {
		this.donationTimeTables = donationTimeTables;
	}


	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Office other = (Office) obj;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		return true;
	}

}