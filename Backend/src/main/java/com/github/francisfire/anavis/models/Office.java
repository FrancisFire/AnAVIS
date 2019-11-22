package com.github.francisfire.anavis.models;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Office {

	private String name;
	private List<Date> donationTimeTables;
	
	public Office() {
	}
	
	/**
	 * 
	 * @param nome
	 * @param donatori
	 */
	public Office(String name) {
		this.name = name;
		this.donationTimeTables = new ArrayList<>();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<Date> getDonationTimeTables() {
		return donationTimeTables;
	}

	public void setDonationTimeTables(List<Date> donationTimeTables) {
		this.donationTimeTables = donationTimeTables;
	}

}