package com.github.francisfire.anavis.models;

import java.util.Date;
import java.util.List;

public class UfficioAVIS {

	private String name;
	private List<Donatore> donors;
	private Date[] donationHours;

	/**
	 * 
	 * @param nome
	 * @param donatori
	 */
	public UfficioAVIS(String name, List<Donatore> donors) {
		this.name = name;
		this.donors = donors;
	}

	/**
	 * 
	 * @param nuovoDonatore
	 */
	public boolean addDonor(Donatore nuovoDonatore) {
		return donors.add(nuovoDonatore);
	}

	public Date[] getDonationHours() {
		return donationHours;
	}

	public String getName() {
		return name;
	}

}