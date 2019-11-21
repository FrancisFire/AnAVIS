package com.github.francisfire.anavis.models;

import java.util.Date;

public class UfficioAVIS {

	private String name;
	private Date[] donationHours;

	/**
	 * 
	 * @param nome
	 * @param donatori
	 */
	public UfficioAVIS(String name) {
		this.name = name;
	}

	public Date[] getDonationHours() {
		return donationHours;
	}

	public String getName() {
		return name;
	}

}