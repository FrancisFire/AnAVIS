package com.github.francisfire.anavis.models;

import java.util.Date;

public class Office {

	private String name;
	private Date[] donationHours;

	/**
	 * 
	 * @param nome
	 * @param donatori
	 */
	public Office(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public Date[] getDonationHours() {
		return donationHours;
	}

}