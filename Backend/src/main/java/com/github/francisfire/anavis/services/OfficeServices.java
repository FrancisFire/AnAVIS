package com.github.francisfire.anavis.services;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import com.github.francisfire.anavis.models.Office;

public class OfficeServices {

	private static OfficeServices instance;
	private Set<Office> offices;

	private OfficeServices() {
		this.offices = new HashSet<>();
	}

	/**
	 * 
	 * 
	 * @return instance
	 */
	public static OfficeServices getInstance() {
		if (instance == null) {
			instance = new OfficeServices();
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
	public Set<Office> getOffices() {
		return new HashSet<>(this.offices);
	}

	/**
	 * 
	 * @param office
	 */
	public Set<Date> getDonationsTimeTable(String office) {
		Office of = getOfficeInstance(office);
		return (of == null) ? new HashSet<>() :getOfficeInstance(office).getDonationTimeTables();
	}

	public boolean addOffice(Office office) {
		return this.offices.add(office);
	}
}