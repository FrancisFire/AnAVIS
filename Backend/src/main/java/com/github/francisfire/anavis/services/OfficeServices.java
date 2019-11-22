package com.github.francisfire.anavis.services;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.github.francisfire.anavis.models.Office;

public class OfficeServices {

	private static OfficeServices instance;
	private List<Office> offices;

	private OfficeServices() {
		this.offices = new ArrayList<>();
	}

	/**
	 * 
	 * 
	 * @return instance
	 */
	public static OfficeServices getInstance() {
		if (instance == null) {

		}

		return instance;
	}

	/**
	 * 
	 * @param office
	 */
	public Office getOfficeInstance(String office) {
		return offices.stream().filter(uff -> uff.getName().equals(office)).findFirst().orElse(null);
	}

	/**
	 * 
	 * @return uffici
	 */
	public List<Office> getOffices() {
		return this.offices;
	}

	/**
	 * 
	 * @param office
	 */
	public List<Date> getDonationsTimeTable(String office) {
		return getOfficeInstance(office).getDonationTimeTables();
	}

}